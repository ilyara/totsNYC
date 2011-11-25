require 'rubygems'
require 'nokogiri'
require 'time'

CONTENT_DIR = '../../content/bits/'

    create_sql = <<SQL
        create table if not exists buildings 
        (id integer primary key, ref_url string, address string, name string, description string,
        neigborhood string, source string, status string, load_time datetime);
        create unique index if not exists idx_ref_url_bldg on buildings(ref_url);
SQL

    create_sql_listings = <<SQL
        create table if not exists listings 
        (id integer primary key, ref_url string, address string, name string, description string,
        neigborhood string, source string, status string, load_time datetime);
        create unique index if not exists idx_ref_url_bldg on buildings(ref_url);
SQL

    create_sql_companies = <<SQL
        create table if not exists companies 
        (id integer primary key, ref_url string, address string, name string, description string,
        neigborhood string, source string, status string, load_time datetime);
        create unique index if not exists idx_ref_url_bldg on buildings(ref_url);
SQL

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

# init db
# if first_run
#   create db structures
#   seed db
# session record 
# for each buildings page
#   get buildings page
#   process each building
#     create building if not exists
# for each building detail page 
#   process
#     attributes
#       link_or_create neighborhood
#       link_or_create leasing manager
#       decode structure
#     description
#     building amenities & services
#     apartment features and amenities
#     comments
#     current listings
# for each [new] current listing
#   get listing
#   process attributes