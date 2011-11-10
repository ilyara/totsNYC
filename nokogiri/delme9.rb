require 'rubygems'
require 'nokogiri'
require 'time'

CONTENT_DIR = '../../content/bits/'

def knock(file_name)
  file = File.open(File.expand_path(CONTENT_DIR+file_name), "r")
  Nokogiri::HTML(file)
end

bits = knock '2.html'

a = bits.at_css('table#capsuletable').css('tr')


a.each do |r|
  e = r.css('td')
  puts e[0].css('b').text
  puts e[1].text # children.select {|e| not e.element?}
  print "=====\n"
end
