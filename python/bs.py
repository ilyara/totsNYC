import urllib2
from BeautifulSoup import BeautifulSoup

url = 'file:///home/ilya/Development/python/ilya/product_categories.html'
page = urllib2.urlopen(url)

# print page.read()
soup = BeautifulSoup(page, convertEntities=BeautifulSoup.HTML_ENTITIES)
siteMap = soup.find('div', "siteMap")

section_header = siteMap.findNext('h2') # ('ul').li
section_content = siteMap.findNext('ul')

print section_header.text

x = section_content.findAll('li')

print [[y.text, y.a['href']] for y in x]

xx = siteMap.findAll('h2')

print [z.text for z in xx]
# print soup.html.body

#for incident in soup('td', width="90%"):
#    where, linebreak, what = incident.contents[:3]
#    print where.strip()
#    print what.strip()
#    print
