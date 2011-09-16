require 'rubygems'
require 'nokogiri'
require 'time'

CONTENT_DIR = './content/cl/'

def knock(file_name)
  file = File.open(File.expand_path(CONTENT_DIR+file_name), "r")
  Nokogiri::XML(file)
end

rss = knock 'index.rss'

rss_links = {}
rss.xpath('//xmlns:item').each do |i|
  rss_links[i.xpath('xmlns:link').text.split(%r{\/|\.})[-2]] = [Time.iso8601(i.xpath('dc:date').text).localtime, i.xpath('dc:title').text]
end

cl1 = knock 'cl1.html'

cl1_links = cl1.css("p a").collect {|e| [e['href'], e.text.strip, e.parent.css("font").text.strip] if e.parent.name == 'p'}.compact!

cl_set = cl1_links.collect {|l| l[0].split(%r{\/|\.})[-2]}

puts "========== in rss but not in cl "
(rss_links.keys - cl_set).uniq.each
puts (rss_links.keys - cl_set).uniq.collect {|f| rss_links.values_at(f)} 
# puts rss_links.select{|k,v| (rss_links.keys - cl_set).uniq.include?(k)} # [(rss_links.keys - cl_set).uniq]
# puts rss_links.values_at((rss_links.keys - cl_set).uniq) # [(rss_links.keys - cl_set).uniq]

puts "========== in cl but not in rss "

puts cl1_links.select{|k| (cl_set - rss_links.keys).uniq.include?(k[0].split(%r{\/|\.})[-2])} # [(rss_links.keys - cl_set).uniq]

puts "=========="
# print (rss_links.keys - cl_set).uniq

# puts rss_links
# rss_links = rss_links.minmax {|x,y| x.key <=> y.key} # .each {|l| puts l.join(', ')}

cl1_links.collect {|l| [l[0].split(%r{\/|\.})[-2], rss_links[l[0].split(%r{\/|\.})[-2]] ? rss_links[l[0].split(%r{\/|\.})[-2]][0] : '--not in rss--']} # .each {|l| puts l.join(' -> ')}

#rss_links.each {|l| puts l.join(', ')}

# rss_links.each {|x| puts x[1][0]}

# cl1_links.each {|a| puts a[1].class}

puts "found #{cl1_links.count} in cl1 and #{rss_links.count} in rss"
cl1_links.minmax {|x,y| x[1] <=> y[1]} .each {|l| puts l.join(', ')}

rss_links.minmax {|x,y| x[1][0] <=> y[1][0]} .each {|l| puts l.join(', ')}
