require 'rubygems'
require 'nokogiri'   
require 'open-uri'  
require 'sqlite3'

LIVE_FLAG = false

class MyDB
  attr_reader :db
  def initialize(db_path="dev.sqlite3")
    @db = SQLite3::Database.new(db_path)
    # drop table if exists refs;
    create_sql = <<SQL
        create table if not exists refs (id integer primary key, cl_url string, cl_description string, cl_area string);
        create unique index if not exists idx_refs on refs(cl_url);
        create table if not exists transfers (id integer primary key, ref_id integer, cl_id string, time_start datetime, status string);
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

class Fetch
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
  
    [body, res.status[0]]
  end
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

def load_up
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
    puts "fetching #{url}" if LIVE_FLAG
    contents = fetch_url(url)[0] if @live_flag
    links, pagination = page_process(contents)
    sql = 'select * from refs where cl_url in (?, ?)'
    rows = mydb.db.execute sql, links.first[0], links.last[0]

    puts "links: #{links.first[0]}, #{links.last[0]}"
    puts "rows: #{rows}"
    if rows.count == 2
      puts "these links are all there - nothing to do"
      pagination = nil 
  #  elsif rows.count == 1
  #    puts "some links on this page need to be processed, but go further"
    else
      puts "saving #{links.count} links"
      f = %w'cl_url cl_description cl_area'
      mydb.bulk_insert f, links
  
      puts "found pagination link: #{start_url}#{pagination}" if pagination
      url = "#{start_url}#{pagination}"
    end
    links = nil
  end
end

def transfer_listings
  file_location = './content/cl/'
  mydb = MyDB.new
  sql = 'select r.id, cl_url from refs r left join transfers t on r.id = t.ref_id where t.id is null limit 100;'
  rows = mydb.db.execute sql
  rows.each do |row|
    cl_id = row[1].split(%r{\/|\.})[-2]
    puts cl_id
    t = Time.now 
    listing_body, fetch_status = fetch_url(row[1]) if LIVE_FLAG 
    sleep 1
    break if LIVE_FLAG && fetch_status != '200'
    if fetch_status == '200'
      File.open(File.expand_path(file_location + cl_id), "w") {|f| f.write(listing_body)} # 
      sql = "insert into transfers ('ref_id', 'cl_id', 'status') values (?, ?, ?)"
      mydb.db.execute sql, [row[0], row[1], fetch_status]
    end
  end
  # File.open(File.expand_path(file_location + cl_id), "w") {|f| f.write "hello\n"}
end

transfer_listings
