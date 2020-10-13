require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/exam', WEBrick::HTTPServlet::ERBHandler, 'exam.html.erb')
server.mount('/expect_myself.cgi', WEBrick::HTTPServlet::CGIHandler, 'expect_myself.rb')
server.mount('/bad.cgi', WEBrick::HTTPServlet::CGIHandler, 'bad.rb')
server.start
