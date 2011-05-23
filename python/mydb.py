#!/usr/bin/python
 
import sqlite3
 
"""
blah blah blah
"""
 
class MyDb:
    def __init__(self, db_file_name = "test.db"):
        try:
            self.conn = sqlite3.connect(db_file_name)
        except sqlite3.OperationalError: # hmm?
            exit(1)
        self.cursor = self.conn.cursor()
        self.cursor.execute('PRAGMA synchronous=OFF')
        self.validateDatabase()
 
    def validateDatabase(self):
        sql = "SELECT * from sqlite_master"
        try:
            self.cursor.execute(sql)
            self.debug("DB is valid")
        except sqlite3.DatabaseError as Err: # hmm?
            print Err
            exit(1)
            
    def createTable(self, tableName):
        sql = "CREATE TABLE %s(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(50), value VARCHAR(50))" % tableName
        try:
            self.cursor.execute(sql)
            self.conn.commit()
            self.debug("Table %s created" % tableName)
        except sqlite3.OperationalError as Err: # hmm?
            self.debug(Err)
            # exit(1)
            
    def execSQL(self, sql):
        try:
            self.cursor.execute(sql)
            self.conn.commit()
            self.debug("Executing sql:\n%s" % sql)
        except sqlite3.OperationalError as Err: # hmm?
            self.debug(Err)
            
    def insertData(self, tableName, fieldArray, dataDict):
        fieldNames = ', '.join(fieldArray)
        valueString = ', '.join(['?' for x in fieldArray])
        sql = "INSERT INTO %(tableName)s(%(fieldNames)s) \nVALUES (%(valueString)s)" \
        % {'tableName': tableName, 'fieldNames': fieldNames, 'valueString': valueString}
        self.debug(sql)
        self.debug(dataDict)
        
        try:
            if len(dataDict) > 1:
                self.cursor.executemany(sql, dataDict)
            else:
                self.cursor.execute(sql, dataDict[0])
            self.conn.commit()
            return self.cursor.lastrowid
        except sqlite3.ProgrammingError as Err:
            print Err
            pass
 
    def parentNKids(self, tableName, fieldArray, parent, kids):
        #insert parent, get pid, insert kids
        pid = self.insertData(tableName, fieldArray, parent)
        print "Inserted %s, assigned id of %d..." % (parent, pid)
        kids = [(pid, ) + kid for kid in kids]
        self.insertData(tableName, fieldArray, kids)
        

    def getData(self, tableName):
        songDict = {}
        sql = "SELECT * FROM %s" % tableName
        self.cursor.execute(sql)
        results = self.cursor.fetchall()

        self.debug(results)
        return results
 
    def closeHandle(self):
        'Closes the connection to the database'
        self.conn.commit() # Make sure all changes are saved
        self.conn.close()

    def debug(self, debugMessage):
        #pass
        print debugMessage
        