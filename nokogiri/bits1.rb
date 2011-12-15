require 'rubygems'
require 'nokogiri'
require 'time'

require './bitsdb'

CONTENT_DIR = '../../content/bits/'
DB_NAME = "bitsdb.sqlite"
BASE_URL = 'http://www.nybits.com/apartments'
BUILDING_TYPE = %w(apartment_buildings condo_buildings coop_buildings)
AREA = %w(midtown_manhattan uptown_manhattan upper_manhattan) #downtown_manhattan

    create_sql_buildings = <<SQL
        create table if not exists buildings 
        (id integer primary key, ref_url string, address string, name string, description string,
        neigborhood string, neigborhood_type string, ownership_type string, source string, 
        status string, load_time datetime);
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

@file_dir = File.expand_path(File.join(File.dirname(__FILE__), CONTENT_DIR))

# File.open(File.join(file_dir, cl_id), "w") {|f| f.write "hello\n"}

@mydb = MyDB.new(File.join(@file_dir, DB_NAME), create_sql_buildings)

def knock(file_name)
  file = File.open(File.join(@file_dir, file_name), "r")
  Nokogiri::HTML(file)
end

def batch(file_name, neigborhood_type="test N", ownership_type="test O")
  puts file_name

  bits = knock file_name

  a = bits.at_css('h2').next.css('li.standardli, li.shadedli') # [125..126]

  # puts a
  fields = %w(name ref_url address neigborhood description neigborhood_type ownership_type)
  records = []
  a.each do |e|
    begin
  #  print "\n=====\n"
  #  print "#{records.count}, "
    name = e.css('a')[0].text
    href = e.css('a')[0]['href']
    if e.at_css('a').next.text[1] == "("
      address = e.at_css('a').next.text.strip[1...-1]
      neigborhood = e.css('a')[1].text
    end
    address = name if (address.nil? or address.empty?) and name[0].to_i > 0
    description = e.at_css('br').next.text.strip.squeeze(" ") if not e.at_css('br').next.nil?
    records.push [name, href, address, neigborhood, description, neigborhood_type, ownership_type]
    # print "name: #{name}\nhref: #{href}\naddress: #{address}\nneigborhood: #{neigborhood}\ndescription: #{description}\n"
    rescue
      puts "problem in #{records.count} (#{name})"
      puts e      
    end
  end

  @mydb.bulk_insert "buildings", fields, records
  puts "Processed #{records.count} records"
end

#file_name = ARGV[0] || '1.html'
#batch(file_name)

area_building_type_file = []
BUILDING_TYPE.each do |b|
  AREA.each do |a|
    batch "#{a}_#{b}.html", a, b
#    area_building_type_file.push "#{a}_#{b}.html"
#    puts "curl #{BASE_URL}/#{a}_#{b}.html > #{a}_#{b}.html"
  end
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