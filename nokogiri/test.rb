require 'rubygems'
require 'nokogiri'   
require 'open-uri'  
require 'sqlite3'

class MyDB
  attr_reader :db
  def initialize(db_path="dev.sqlite3")
    @db = SQLite3::Database.new(db_path)
    create_sql = <<SQL
        drop table refs;
        create table if not exists refs (id integer primary key, cl_url string, cl_description string, cl_area string);
        create unique index if not exists idx_refs on refs(cl_url);
SQL
    @db.execute_batch create_sql
    @db.execute "PRAGMA journal_mode=MEMORY"
    @db.execute "PRAGMA synchronous=OFF"
    @db.execute "PRAGMA temp_store=MEMORY"
    @db.execute "PRAGMA count_changes=OFF"
  end

  def bulk_insert(field_names, dataset)
    sql = "insert or ignore into refs (#{field_names.join(', ')}) values (?, ?, ?)"
    @db.prepare sql do |st|
      @db.transaction
        dataset.each do |r| 
          st.execute r # if t.to_s.scan(/(\d)\1+/).count == 0
        end
      @db.commit
    end
  end
end


def fetch_url(url='http://www.ruby-doc.org/core/classes/Bignum.html')
  headers = {
  'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1',
  'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Encoding' => 'gzip,deflate,sdch',
  'Accept-Language' => 'en-US,en;q=0.8',
  'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.3'
  }

  res = open(url, headers)
  puts res.meta
  puts res.status[0]

  unless res.content_encoding == ['gzip'] then
    body = res.read
  else
    body = Zlib::GzipReader.new(res).read
  end
  
  body
end

def page_process(contents)
  doc = Nokogiri::HTML(contents)
  puts doc.at_css("title").text

  # links = doc.css("p a").collect {|e| [e['href'], e.text.strip, e.parent.css("font").text.strip]}
  links = []
  pagination = nil
  doc.css("p a").each do |e|
    if e.parent.name == 'p'
      links << [e['href'], e.text.strip, e.parent.css("font").text.strip]
    else
      pagination = e['href']
    end
  end
  [links, pagination]
end


file_location = './content/cl/cl1.html'
file = File.open(File.expand_path(file_location), "r")

start_url = 'http://newyork.craigslist.org/mnh/sub/'
url = start_url

contents = file.read

mydb = MyDB.new
pagination = ''
while pagination do
  puts "in cycle"
  sleep 3
  # contents = fetch_url(url)
  links, pagination = page_process(contents)
  sql = 'select * from refs where cl_url in (?, ?)'
  rows = mydb.db.execute sql, links.first[0], links.last[0]

  if rows.count == 2
    puts "these links are all there - nothing to do" 
  elsif rows.count == 1
    puts "some links on this page need to be processed, but go no further"
  else
    puts "processing #{links.count} links"
    f = %w'cl_url cl_description cl_area'
    mydb.bulk_insert f, links
  
    puts "found pagination link: #{start_url}#{pagination}" if pagination
    url = "#{start_url}#{pagination}"
  end
end