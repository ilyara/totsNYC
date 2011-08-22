"""
Analyze data structure of a json file
with an eye on storing data in a relational DB
"""
import json

file = '/Users/ilya/crunchtest/crunch/mahalo'
page = open(file, 'r')
print "loading record..."
c = json.loads(page.read())
print "loaded. Top-level dictionary contains %d keys" % len(c)
# print c.keys()

tables = {}
objects = {}

def walk(x, level=0, key='topLevel', parent_type=None):
  indent = "\t" * level
  if isinstance(x, dict):
    if parent_type == dict:
      print "%sobject(of type %s): %d fields" % (indent, key, len(x.keys()))	
      objects[key] = x.keys()
    else:
      print "%srecord(in %s): %d fields" % (indent, key, len(x.keys()))
      tables[key] = x.keys()
    [walk(x[k], level+1, k, dict) for k in x.keys()]
  elif isinstance(x, list):
    print "%sreferences table(%s): %d records" % (indent, key, len(x))
    [walk(i, level+1, key, list) for i in x]
	#   elif isinstance(x, unicode):
	# print "%s:%s" % (key, x)
  else:
	print "%s%s(%s):%s" % (indent, key, type(x).__name__, x)
	
walk(c)

print "====Tables:"
for table in tables.keys():
  print "%s:%s" % (table, ', '.join(tables[table]))

print "====Objects:"
for obj in objects.keys():
  print "%s:%s" % (obj, ', '.join(objects[obj]))
