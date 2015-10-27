require 'webrick'
require 'byebug'

server = WEBrick::HTTPServer.new Port: 3000
server.mount_proc("/") do |rq, r|
  address = rq.unparsed_uri
  r.body = address

end

trap("INT") {server.shutdown}

server.start

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
