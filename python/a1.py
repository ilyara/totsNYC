import urllib2
from BeautifulSoup import BeautifulSoup
import json
import mydb


url = 'file:///home/ilya/Development/python/ilya/product_categories.html'
page = urllib2.urlopen(url)

# print page.read()
soup = BeautifulSoup(page, convertEntities=BeautifulSoup.HTML_ENTITIES)
siteMap = soup.find('div', "siteMap")

section_header = siteMap.findNext('h2') # ('ul').li
section_content = siteMap.findNext('ul')

# print section_header.text

x = section_content.findAll('li')

# print [(y.text, y.a['href']) for y in x]

catY = [catX.text for catX in siteMap.findAll('h2')]
# subCat = [ss.findAll('li') for ss in siteMap.findAll('ul')]

subCat = [ss.findAll('li') for ss in siteMap.findAll('ul')]

ssubCat = [[(y.text, y.a['href']) for y in q] for q in subCat]

haha = zip(catY, ssubCat)

# print "\n".join(["Category: %s, %d" % (q[0], len(q[1])) for q in haha])

db = mydb.MyDb()
sql = """CREATE TABLE tree(
id INTEGER PRIMARY KEY AUTOINCREMENT, 
pid INTEGER, 
name VARCHAR(50), 
value VARCHAR(50)
)"""
db.execSQL(sql)

# print json.dumps(haha)
# db.insertData('tree', ['pid', 'name', 'value'], testdata)

[db.parentNKids('tree', ['pid', 'name', 'value'], [('', q[0], '')], q[1]) for q in haha]

# print db.getData("tree")
