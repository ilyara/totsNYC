import json, ConfigParser, os
from BeautifulSoup import BeautifulSoup

config = ConfigParser.ConfigParser()
config.read("config.ini")
dirpath = config.get("Config", "ContentDirectory")

filepath = 'googleadwords/categories.json'

file = os.path.join(dirpath, filepath) 
page = open(file, 'r')
c = json.loads(page.read())

def walk(x, level=0):
  if isinstance(x, dict):
    print "%s%s" % ("\t" * level, x['localizedName'])
    walk(x['children'], level+1)
  elif isinstance(x, list):
    [walk(l, level) for l in x]

walk(c)
# print json.dumps(c, sort_keys = False, indent=4)
exit(1)

