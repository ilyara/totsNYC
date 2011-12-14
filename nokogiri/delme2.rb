x = 'http://newyork.craigslist.org/mnh/sub/2598782017.html'
cl_id = x.split(%r{\/|\.})[-2]

file_dir = File.expand_path(File.join(File.dirname(__FILE__), '/content/cl/'))
File.open(File.join(file_dir, cl_id), "w") {|f| f.write "hello\n"}