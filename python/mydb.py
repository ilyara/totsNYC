#!/usr/bin/python
 
import sqlite3
 
"""
songDict:
the key is the song
songDict[0] = path
songDict[1] = artist
songDict[2] = album
"""
 
class MyDb:
    def __init__(self, db_file_name = "test.db"):
        try:
            self.conn = sqlite3.connect(db_file_name)
        except sqlite3.OperationalError: # hmm?
            exit(1)
        self.cursor = self.conn.cursor()
        self.validateDatabase()
 
    def validateDatabase(self):
        sql = "SELECT * from sqlite_master"
        try:
            self.cursor.execute(sql)
            print "DB is valid"
        except sqlite3.DatabaseError as Err: # hmm?
            print Err
            exit(1)
            
    def createTable(self, tableName):
        sql = "CREATE TABLE %s(id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(50), value VARCHAR(50))" % tableName
        try:
            self.cursor.execute(sql)
            self.conn.commit()
            print "Table %s created" % tableName
        except sqlite3.OperationalError as Err: # hmm?
            print Err
            # exit(1)
            
    def execSQL(self, sql):
        try:
            self.cursor.execute(sql)
            self.conn.commit()
            print "Executing sql:\n%s" % sql
        except sqlite3.OperationalError as Err: # hmm?
            print Err
            
    def insertData(self, tableName, fieldArray, dataDict):
        fieldNames = ', '.join(fieldArray)
        valueString = ', '.join(['?' for x in fieldArray])
        sql = "INSERT INTO %(tableName)s(%(fieldNames)s) \nVALUES (%(valueString)s)" \
        % {'tableName': tableName, 'fieldNames': fieldNames, 'valueString': valueString}
        print sql
        print dataDict
        
        try:
            if len(dataDict) > 1:
                self.cursor.executemany(sql, dataDict)
            else:
                self.cursor.execute(sql, dataDict[0])
            self.conn.commit()
        except sqlite3.ProgrammingError as Err:
            print Err
            pass
 
    def getData(self, tableName):
        songDict = {}
        sql = "SELECT * FROM %s" % tableName
        self.cursor.execute(sql)
        results = self.cursor.fetchall()
        print results
 
        return results
 
    def closeHandle(self):
        'Closes the connection to the database'
        self.conn.commit() # Make sure all changes are saved
        self.conn.close()
