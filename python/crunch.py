"""
Crunchbase API test

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
import json, ConfigParser, os

class Crunch:
	def __init__(self, ini_file = "crunch.ini", db_file = "test.db"):
		"""
		Things to check:
		- do we have a readable ini file?
		- do we have an existing DB?
		- does it have queue management tables / correct schema version?
		"""
		
		self.worker = '%d/%d' % (os.getuid(),os.getpid())
		config = ConfigParser.ConfigParser()
		config.read(ini_file)
		try:
			db_file = config.get("Config", "DBFile")
			raw_data_dir = config.get("Config", "RawDataDir")
		except ConfigParser.NoSectionError: # config file or section does not exist
			# default values
			pass
		print "Using DB: %s" % db_file
		
		import mydb
		self.db = mydb.MyDb(db_file)
		self.db.debug_flag = False
		self.create_api_tables()
		# self.admin_tasks()
		self.register_worker()
		self.assign_job()
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
		url VARCHAR(1024),
		referrer VARCHAR(1024),
		load_requested DATETIME DEFAULT CURRENT_TIMESTAMP,
		worker VARCHAR(256),
		load_start DATETIME,
		load_completed DATETIME,
		status INTEGER
		)"""
		self.db.execSQL(sql)

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
			print 'got one!'
			sql = "SELECT * FROM mgmt_url WHERE worker = '%s'" % self.worker
			print self.db.runQuery(sql)
		else:
			print 'nothing to do!'
		pass
		
	def admin_tasks(self):
		sql = """UPDATE mgmt_url SET worker = NULL"""
		self.db.execSQL(sql)
		pass
		
c = Crunch()