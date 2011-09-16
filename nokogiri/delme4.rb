require 'rubygems'
require 'nokogiri'
require 'time'

file_location = './content/cl/'
file_name = 'index.rss'

file = File.open(File.expand_path(file_location+file_name), "r")

doc = Nokogiri::XML(file.read)
# doc.remove_namespaces!

links = doc.xpath('//xmlns:item').map do |i|
  [i.xpath('xmlns:link').text.split(%r{\/|\.})[-2], Time.iso8601(i.xpath('dc:date').text).localtime, i.xpath('dc:type').text]
end

links.each {|l| puts l.join(', ')}


# puts doc.xpath('//xmlns:item')[0]

# puts "catcher: #{doc.xpath('//channel/items/Seq').children.count}"

# links = doc.xpath('//item').map do |i|
#   puts 'OK'
#       {'title' => i.xpath('title'), 'link' => i.xpath('link'), 'description' => i.xpath('description')}
# end

# puts doc.xpath('//channel/items/Seq/li').count
# puts doc.xpath('//rdf:RDF/xmlns:channel//rdf:Seq/rdf:li').count #.children[1]
# puts doc.xpath('//xmlns:item')[0].xpath('dc:date').text

# doc.xpath('//xmlns:item')[0].children.each {|e| puts "#{e.name}: #{e.text}" if e.element? and e.text.length < 100}
# doc.xpath('//xmlns:item')[0].children.each {|e| puts "#{e.name}:#{e.path}" if e.element?}