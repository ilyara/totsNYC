import mydb

tableName = 'tree'
db = mydb.MyDb()
sql = """CREATE TABLE tree(
id INTEGER PRIMARY KEY AUTOINCREMENT, 
pid INTEGER, 
name VARCHAR(50), 
value VARCHAR(50)
)"""
db.execSQL(sql)
testdata = [
            (0, "Ella", "Fitzgerald"),
            (0, "Louis", "Armstrong"),
            (0, "Miles", "Davis")
            ]
testdata = [(0, "Ilya", "Ravich")]


# print len(testdata)
db.insertData(tableName, ['pid', 'name', 'value'], testdata)
print "Inserted row_id %s" % db.cursor.lastrowid
db.getData(tableName)
