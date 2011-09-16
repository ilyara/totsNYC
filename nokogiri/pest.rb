require 'rubygems'
require 'nokogiri'
require 'time'
require 'open-uri'  
require 'sqlite3'

require './mydb'
require './fetch'

CONTENT_DIR = './content/cl/'
LOAD_URL = 'http://newyork.craigslist.org/mnh/sub/'
RSS_FILE = 'index.rss'

LIVE_FLAG = false

def knock(file_name)
  if LIVE_FLAG
    file = Fetch.fetch_url(LOAD_URL+file_name)
  else
    file = File.open(File.expand_path(CONTENT_DIR+file_name), "r")
  end
  Nokogiri::XML(file)
end


rss = knock RSS_FILE
rss_links = 
rss.xpath('//xmlns:item').collect do |i|
  [
  i.xpath('xmlns:link').text.split(%r{\/|\.})[-2], 
  i.xpath('xmlns:link').text, 
  Time.iso8601(i.xpath('dc:date').text).localtime.iso8601, 
  i.xpath('dc:title').text, i.xpath('xmlns:description').text,
  Time.now.iso8601
  ]
end

mydb = MyDB.new
f = %w'cl_ref cl_url cl_issued cl_title cl_description load_time' # ' cl_area'
puts "New entries: #{mydb.bulk_insert f, rss_links}"


