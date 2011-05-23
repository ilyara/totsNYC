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
		db = mydb.MyDb(db_file)
		sql = """CREATE TABLE mgmt_api(
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		pid INTEGER,
		name VARCHAR(50),
		value VARCHAR(50),
		"rc" DATETIME DEFAULT CURRENT_TIMESTAMP
		)"""
		db.execSQL(sql)
		# os.getpid(), os.getuid(), os.uname()¶


		pass
	
	def register_worker(self):
		pass
		
	def admin_tasks(self):
		pass
		
c = Crunch()