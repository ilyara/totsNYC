"""
Crunchbase API test
5/27/2011

- uses settings from config file
- responds to commands (using db table as queue)
- respects rate limits
- uses db to crawl links
- saves responses to file system 
- saves extracted records to DB

ToDo:
- auto-create, auto-manage DB structure

LifeCycle:
- connect to DB
- register process as worker
- execute admin que cleanup
- self-assign task(s) from pending pool
- process task(s)
- record task execution
- check for outstanding signals
- continue with task assignment/execution

"""
import json, ConfigParser, os, sys, urllib2, gzip, time, random
from StringIO import StringIO
from getopt import gnu_getopt, GetoptError

class Crunch:

	ops = 'companies, people, products, financial-organizations, service-providers'
	op = 'dryrun'
	
	def __init__(self, ini_file = "crunch.ini", db_file = "test.db", crunch_out_dir = '/tmp'):
		"""
		Things to check:
		- do we have a readable ini file?
		- do we have an existing DB?
		- does it have queue management tables / correct schema version?
		"""

		oplist = [i.strip() for i in self.ops.split(',')] 
		try:
			options = gnu_getopt(sys.argv[1:], 'l:w:', oplist)
			print options
		except GetoptError, e:
			print str(e)
			exit(1)
		
		self.worker = '%d/%d' % (os.getuid(),os.getpid())
		config = ConfigParser.ConfigParser()
		config.read(ini_file)
		try:
			crunch_out_dir = config.get("Common", "CrunchOutDir")
			db_file = os.path.join(crunch_out_dir, config.get("Config", "DBFile"))
			self.raw_data_dir = os.path.join(crunch_out_dir, config.get("Config", "RawDataDir"))
			rate_limit = int(config.get("Config", "RateLimit"))
		except ConfigParser.NoSectionError: # config file or section does not exist
			pass 							# using default values

		if options[0][0][1] in oplist:
			opflag, self.op = options[0][0]
			try:
				db_file = os.path.join(crunch_out_dir, config.get(self.op, "DBFile"))
				self.raw_data_dir = os.path.join(crunch_out_dir, config.get(self.op, "RawDataDir"))
				self.list_file = config.get(self.op, "ListFile")
				self.singular = config.get(self.op, "Singular")
			except ConfigParser.NoSectionError: # config file or section does not exist
				pass
		else:
			print "must specify a valid action:\n%s" % self.ops
			exit(1)

		print "Pricessing: %s" % self.op
		print "Using DB: %s" % db_file
		print "Rate Limit: %d" % rate_limit

		if not os.path.isfile(db_file):
			print "%s not found" % db_file 
		
		import mydb
		self.db = mydb.MyDb(db_file)
		self.db.debug_flag = False
		self.create_api_tables()
		self.admin_tasks()
		iters = 0
		if opflag == '-w' and self.op != 'dryrun':
			load_completed = True
			print "activating worker mode"
		else:
			load_completed = False
		
		while load_completed:
			iters = iters + 1
			self.register_worker()
			id, url, keyref = self.assign_job()[0]
			if url:
				load_completed = self.execute_job(url, keyref)
				if load_completed:
					s = 1
					print "sleeping for %d seconds" % s
					time.sleep(s)
				else:
					exit(1)
			else:
				exit(1)
		
		if opflag == '-l' and self.op not in ['dryrun', 'worker']:
			print 'click'
			url_mask = "http://api.crunchbase.com/v/1/%s" % self.singular + "/%s.js"
			self.load_tc_list(self.list_file, url_mask)
		else:
			print 'no data load requested'
		
		# os.getpid(), os.getuid(), os.uname()
		# select * from mgmt_api where sess_lastupdate < datetime('now', '-10 seconds');

		# sql = "SELECT tbl_name FROM sqlite_master WHERE tbl_name = 'mgmt_api'"
		# print self.db.runQuery(sql)

		pass

	def create_api_tables(self):
		sql = """CREATE TABLE mgmt_worker(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		worker VARCHAR(256),
		sess_start DATETIME DEFAULT CURRENT_TIMESTAMP,
		sess_lastupdate DATETIME DEFAULT CURRENT_TIMESTAMP
		)"""
		self.db.execSQL(sql)

		sql = """CREATE TABLE mgmt_url(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		keyref VARCHAR(1024),
		url VARCHAR(1024),
		referrer VARCHAR(1024),
		load_requested DATETIME DEFAULT CURRENT_TIMESTAMP,
		worker VARCHAR(256),
		load_start DATETIME,
		load_completed DATETIME,
		status INTEGER
		)"""
		self.db.execSQL(sql)

#		CREATE INDEX worker_idx ON mgmt_url(worker)
# 		UNIQUE

		sql = """CREATE TABLE mgmt_com(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		worker VARCHAR(256),
		com VARCHAR(1024),
		com_response VARCHAR(1024),
		com_created DATETIME DEFAULT CURRENT_TIMESTAMP,
		com_completed DATETIME,
		status INTEGER
		)"""
		self.db.execSQL(sql)
		
		pass
	
	def register_worker(self):
		self.db.insertData('mgmt_worker', 'worker', self.worker)
		pass

	def assign_job(self):
		# sql = "UPDATE mgmt_url SET worker = '%s' WHERE worker IS NULL LIMIT 1" % self.worker
		sql = "UPDATE mgmt_url SET worker = '%s' WHERE id IN (SELECT id FROM mgmt_url WHERE worker IS NULL LIMIT 1)" % self.worker
		
		# print self.db.runQuery(sql)
		# self.db.insertData('mgmt_worker', 'worker', '%d/%d' % (os.getuid(),os.getpid()))
		self.db.execSQL(sql)
		if self.db.cursor.rowcount:
			# print 'Job assigned!'
			sql = "SELECT id, url, keyref FROM mgmt_url WHERE status IS NULL AND worker = '%s'" % self.worker
			return self.db.runQuery(sql)
		else:
			print 'nothing to do!'
			return [(None, None, None)]
		pass
		
	def execute_job(self, url, keyref):
		print "retrieving %s" % url
		sql = "UPDATE mgmt_url SET load_start = datetime('now') WHERE status IS NULL AND url = '%s' AND worker = '%s'" % (url, self.worker)
		self.db.execSQL(sql)
		if self.db.cursor.rowcount:
			status, data = self.fetch_url(url, os.path.join(self.raw_data_dir, keyref))
			# print "status: %s" % status
			if status == "200 OK":
				sql = "UPDATE mgmt_url SET load_completed = datetime('now'), status = '200 OK' WHERE url = '%s' AND worker = '%s'" % (url, self.worker)
				self.db.execSQL(sql)
				return time.time()
			else:
				sql = "UPDATE mgmt_url SET load_completed = datetime('now'), status = '%s' WHERE url = '%s' AND worker = '%s'" % (status, url, self.worker)
				self.db.execSQL(sql)
				return time.time()
#			else:
#				print "terminating..."
#				return False

	def fetch_url(self, url, filename):
		print "will save %s to %s" % (url, filename)

		user_agent = 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2a1pre) Gecko/20090428 Firefox/3.6a1pre'
		headers =  {'User-agent': user_agent, 'Accept-encoding': 'gzip', 'Referer': url}
		data = None
		try:
			request = urllib2.Request(url, data, headers)
			response = urllib2.urlopen(request)
			# print response.info()
		except urllib2.HTTPError as Err:
			print Err
			return Err, None
		status = response.headers.get('Status')
		if response.info().get('Content-Encoding') == 'gzip':
		    buf = StringIO(response.read())
		    f = gzip.GzipFile(fileobj=buf)
		    data = f.read()
		else:
			data = response.read()
		
		if not os.path.isdir(self.raw_data_dir):
			os.makedirs(self.raw_data_dir)
		f = open(filename, 'w')
		f.write(data)
		f.close()
		
		return status, data
		# import gzip
		# gzip.GzipFile(fileobj)
		# content = response.read()
		
		# req = urllib2.Request(url, data, headers)
		# response = urllib2.urlopen(req)
		# the_page = response.read()
		
        # content = response.read()
        # print response.headers
		
	def admin_tasks(self):
		sql = """UPDATE mgmt_url SET worker = NULL WHERE WORKER IS NOT NULL AND (load_start < datetime('now', '-10 seconds') OR load_start IS NULL) AND load_completed IS NULL"""
		self.db.execSQL(sql)
		pass

	def load_tc_companies(self):
		file = '/home/ec2-user/Development/hiertest/crunchbase/companies.js'
		page = open(file, 'r')
		print "loading tc companies"
		c = json.loads(page.read())
		print "loaded %d companies" % len(c)
		tc_fields = c[0].keys()
		tc_values = [i.values() for i in c]
		print tc_fields
		print tc_values[0]
		self.db.insertData('mgmt_url', 'url, keyref', tc_values)

	def load_tc_list(self, file, url_mask, url_field='permalink', keyref_field='permalink'):
		page = open(file, 'r')
		print "loading tc %s" % self.op
		c = json.loads(page.read())
		print "loaded %d %s" % (len(c), self.op)
		tc_fields = c[0].keys()
		tc_values = [(url_mask % i[url_field], i[keyref_field]) for i in c]
		print tc_fields
		print tc_values[0]
		self.db.insertData('mgmt_url', 'url, keyref', tc_values)
		
		pass
		
c = Crunch()
