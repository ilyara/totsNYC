import json, ConfigParser, os
from BeautifulSoup import BeautifulSoup

config = ConfigParser.ConfigParser()
config.read("config.ini")
dirpath = config.get("Config", "ContentDirectory")

filepath = 'craigslist/main.html'

def q(e):
  if e:
    return e.text
  else:
    return e

def h(e):
  if e:
    return e['href']
  else:
    return e


file = os.path.join(dirpath, filepath) 
page = open(file, 'r')
soup = BeautifulSoup(page, convertEntities=BeautifulSoup.HTML_ENTITIES)

lst = [(c.text, h(c.a) # map(lambda x: x['href'] if x else '', [c.a])[0] 
          , [(i.a.text, i.a['href']) for i in c.findNextSibling('div', 'cats')('li')]
        )
      for c in soup.find('table', id='main')('h4', 'ban')]

print json.dumps(lst)
exit(1)

span = pdtl[0].span.text
a = pdtl[0].find('a')

# print span
print a.contents[0].strip()
print a.contents[1].text
# print dir(a)

exit(1)
print [e.text for e in siteMap.findAll('h3') if e.findNext().name == 'a']
print [(e.name, e['class']) for e in siteMap.findAll('div', 'content-group')[0].findAll(recursive=False)] # , attrs={'class':'sublist'})
print [e.text for e in siteMap.findAll('div', 'content-group')[0].findAll(recursive=False)[0] if e.findNext().name == 'a']

exit(1)
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
