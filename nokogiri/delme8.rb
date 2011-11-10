require 'rubygems'
require 'nokogiri'
require 'time'

CONTENT_DIR = '../../content/bits/'

def knock(file_name)
  file = File.open(File.expand_path(CONTENT_DIR+file_name), "r")
  Nokogiri::HTML(file)
end

bits = knock '1.html'

a = bits.at_css('h2').next.css('li.standardli, li.shadedli')[125..126]

puts a
a.each do |e|
  print "\n=====\n"
  name = e.css('a')[0].text
  href = e.css('a')[0]['href']
  address = e.at_css('a').next.text.strip[1...-1]; address = name if address.empty?
  neigborhood = e.css('a')[1].text
  description = e.at_css('br').next.text.strip.squeeze(" ") if not e.at_css('br').next.nil?
  print "name: #{name}\nhref: #{href}\naddress: #{address}\nneigborhood: #{neigborhood}\ndescription: #{description}"
end
