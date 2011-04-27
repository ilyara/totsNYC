# test module sqlite3 write and read a database file
# (Python25 and higher have module sqlite3 built in)
# sqlite3.connect(database, timeout=5.0, isolation_level=None,
#   detect_types=0, factory=100)
# keywords:
# timeout=5.0 --> allows multiple access for 5 seconds
# isolation_level=None -->  autocommit mode
# detect_types=0 --> native types TEXT, INTEGER, FLOAT, BLOB and NULL
# factory=100 --> statement cache to avoid SQL parsing overhead
 
import sqlite3
 
# create/connect to a permanent file database
con = sqlite3.connect("my_db.db3")
 
# establish the cursor, needed to execute the connected db
cur = con.cursor()
 
# create/execute a table:
# (optionally used capital letters to show commands)
cur.execute('CREATE TABLE IF NOT EXISTS clients \
    (id INT PRIMARY KEY, \
    firstname CHAR(60), \
    lastname CHAR(60))')
 
# insert several lines at once using a
# list of (id, firstname, lastname) tuples
# use try/except or the existing db will complain about
# the non-unique id since it is already in the db
try:
    clients = [
    (107, "Ella", "Fitzgerald"),
    (108, "Louis", "Armstrong"),
    (109, "Miles", "Davis")
    ]
    cur.executemany("INSERT INTO clients (id, firstname, lastname) \
        VALUES (?, ?, ?)", clients )
except:
    pass
 
# add another client
# use try/except or the existing db will complain about
# the non-unique id if it is already in the db
try:
    new_client = (110, "Benny", "Goodman")
    cur.execute("INSERT INTO clients (id, firstname, lastname) \
        VALUES (?, ?, ?)", new_client)
except:
    pass
 
# important if you make changes to the database
# commits current data to the db file (data is persistant now)
con.commit()
 
# now test it
# get data row by row
print("Show data row by row:")
# also orders/sorts data by lastname
cur.execute('SELECT id, firstname, lastname FROM clients \
    ORDER BY lastname')
for row in cur:
    print(row)
 
print('-'*40)
 
# select just one data item from each row ...
cur.execute('SELECT firstname FROM clients')
print(cur.fetchall())
 
print('-'*40)
 
# or ...
cur.execute('SELECT firstname FROM clients')
for row in cur:
    print(row[0])
 
print('-'*40)
 
# select a specific data row ...
cur.execute('SELECT * FROM clients WHERE lastname="Davis"')
print(cur.fetchall())
 
print('-'*40)
 
# show the table header
# use only the first item of the tuple info
col_name_list = [tup[0] for tup in cur.description]
print("Table header:")
print(col_name_list)
 
# finally ...
con.close()
 
"""my output with Python3 -->
 
Show data row by row:
(108, 'Louis', 'Armstrong')
(109, 'Miles', 'Davis')
(107, 'Ella', 'Fitzgerald')
(110, 'Benny', 'Goodman')
----------------------------------------
[('Ella',), ('Louis',), ('Miles',), ('Benny',)]
----------------------------------------
Ella
Louis
Miles
Benny
----------------------------------------
[(109, 'Miles', 'Davis')]
----------------------------------------
Table header:
['id', 'firstname', 'lastname']
"""