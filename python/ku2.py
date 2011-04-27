#!/usr/bin/python
# sqlite3 example
 
import sqlite3
 
"""
songDict:
the key is the song
songDict[0] = path
songDict[1] = artist
songDict[2] = album
"""
 
class Database:
    def __init__(self):
        try:
            self.conn = sqlite3.connect('songs.db')
        except sqlite3.OperationalError: # Can't locate database file
            exit(1)
        self.cursor = self.conn.cursor()
 
    def createDatabase(self):
        cmd = "CREATE TABLE allsongs(path VARCHAR(100), name VARCHAR(50), artist VARCHAR(50), album VARCHAR(50))"
        self.cursor.execute(cmd)
        self.conn.commit()
 
    def insertSongs(self, songDict):
        for song in songDict:
            cmd = """INSERT INTO allsongs(path, name, artist, album) VALUES("%s", "%s", "%s", "%s")""" % (song, songDict[song][0], songDict[song][1], songDict[song][2])
            print "Inserting", song+"..."
            self.cursor.execute(cmd)
 
        self.conn.commit()
 
    def getSongs(self):
        songDict = {}
        cmd = "SELECT * FROM allsongs"
        self.cursor.execute(cmd)
        results = self.cursor.fetchall()
        for song in results:
            songDict[song[0]] = (song[1], song[2], song[3])
 
        return songDict
 
    def closeHandle(self):
        'Closes the connection to the database'
        self.conn.commit() # Make sure all changes are saved
        self.conn.close()
