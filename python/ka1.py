import mydb

tableName = 'test2'
db = mydb.MyDb()
db.createTable(tableName)
testdata = [
            ("Ella", "Fitzgerald"),
            ("Louis", "Armstrong"),
            ("Miles", "Davis")
            ]
db.insertData(tableName, ['name', 'value'], testdata)
db.getData(tableName)