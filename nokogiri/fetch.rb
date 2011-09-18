class Fetch
  attr_reader :body, :meta, :base_uri, :status
  class << self
    def fetch_url(url)
      headers = {
      'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.220 Safari/535.1',
      'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Encoding' => 'gzip,deflate,sdch',
      'Accept-Language' => 'en-US,en;q=0.8',
      'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.3'
      }

      res = open(url, headers)
      @@meta = res.meta
      @@base_uri = res.base_uri
      @@status = res.status[0]

      unless res.content_encoding == ['gzip'] then
        @@body = res.read
      else
        @@body = Zlib::GzipReader.new(res).read
      end
  
      [@@body, res.status[0]]
    end
  end
end
