#!/usr/bin/env ruby
require 'logger'
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

@status = '200'

def knock(file_name)
  if LIVE_FLAG
    file, @status = Fetch.fetch_url(LOAD_URL+file_name)
    log.debug "#{Fetch.base_uri}\n#{Fetch.meta}\n#{Fetch.status}"
  else
    file = File.open(File.expand_path(CONTENT_DIR+file_name), "r")
  end
  Nokogiri::XML(file)
end

log = Logger.new('log.txt')

log.debug "starting up"

mydb = MyDB.new

while @status == '200' do
  begin
    rss = knock RSS_FILE
  rescue Exception => e
    debug.log "Oops!: #{e.message}"
  end
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

  # puts rss_links.collect {|l| "'#{l[0]}'"} .join(', ') 

  sql = 'select cl_ref from refs where cl_ref in (' + rss_links.collect {|l| "'#{l[0]}'"} .join(', ')  + ")"

  rows = mydb.db.execute sql

  rows.flatten!

  rss_links.select! {|l| true unless rows.include?(l[0].to_i)}

  log.debug "#{Time.now.localtime}: Adding #{rss_links.count} new records";

  f = %w'cl_ref cl_url cl_issued cl_title cl_description load_time' # ' cl_area'
  mydb.bulk_insert f, rss_links
break unless LIVE_FLAG
  sleep 10
end

puts "Finished."

