x = 'http://newyork.craigslist.org/mnh/sub/2598782017.html'
cl_id = x.split(%r{\/|\.})[-2]

file_location = './content/cl/'
File.open(File.expand_path(file_location + cl_id), "w") {|f| f.write "hello\n"}