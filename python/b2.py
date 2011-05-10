import urllib2
from BeautifulSoup import BeautifulSoup

url = 'file:///home/ilya/Development/python/ilya/agriculture_p1.html'
page = urllib2.urlopen(url)
# print page.read()
soup = BeautifulSoup(page, convertEntities=BeautifulSoup.HTML_ENTITIES)
cat = soup.find('div', 'cateMenu')#{'id':'categories'})

#print cat.findNext('h4').text
#print cat.findNext('h4').text
#print '-->' + cat.ul.li.text
sec = cat.findAll('div', 'catesub')
print [e.name for e in cat.findAll(recursive=False)]
print [e.name for e in cat.div.ul.findAll(recursive=False)]
print [e.name for e in cat.div.ul.div.div.findAll(recursive=False)]

print [e.text for e in cat.findAll('h4')]
print "=== All (non-recursive) link names in ul 0:"
print [(e.name, e.text) for e in cat.ul.findAll('li',recursive=False)]
print "=== All links in sec 0:"
print [e.text for e in sec[0].findAll('a')]
print "=== structure of sec 1 (recursive):"
print [(e.name, 'parent:' + e.parent.name) for e in sec[1].findAll('ul')]
print "=== All links in sec 1 (recursive):"
zz = [zz.findAll('a') for zz in sec[1].findAll('ul')]
print [[xa.text for xa in xx] for xx in zz]
# print [e.text for e in [zz.findAll('a') for zz in z]]
# "\n".join([e.text for e in cat.findAll('a')])

exit(1)
print [c.text for c in cat.findAll('h4')]

# print len(cat.findAll('a'))
x = [c.text for c in cat.findAll('a')]
print "\n".join(["Cat: %s" % y for y in x])
print len(x)

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

print "\n".join(["Category: %s, %d" % (q[0], len(q[1])) for q in haha])

# y1 = [y0.findAll('li') for y0 in yy]

# print zip(xx, yy)
# print [z.text for z in xx]
# print soup.html.body

#for incident in soup('td', width="90%"):
#    where, linebreak, what = incident.contents[:3]
#    print where.strip()
#    print what.strip()
#    print
