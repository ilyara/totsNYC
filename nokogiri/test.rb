require 'rubygems'
require 'nokogiri'   
require 'open-uri'  
  
# doc.xpath('//span[@class="method-name"]').each do | method_span |  
#     puts method_span.content  
#     puts method_span.path  
#     puts  
# end
def fetch_url()
  headers = {
  'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1',
  'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
  'Accept-Encoding' => 'gzip,deflate,sdch',
  'Accept-Language' => 'en-US,en;q=0.8',
  'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.3'
  }

  url = 'http://www.ruby-doc.org/core/classes/Bignum.html'
  res = open(url, headers)
  puts res.meta
  puts res.status[0]

  unless res.content_encoding == ['gzip'] then
    body = res.read
  else
    body = Zlib::GzipReader.new(res).read
  end
end

file_location = '/Users/appleuser/Development/content/cl/cl1.html'

file = File.open(file_location, "r")
contents = file.read

# puts doc
doc = Nokogiri::HTML(contents)
puts doc.at_css("title").text
doc.css("p a").each do |b|
#  puts b.css_path
  puts b.text
  # puts "\t" + 
  # b.css("a").each do |a|
  # end
end
