require 'drb/drb'
require 'search_engine'
# [Terminal server with jruby]
# jruby aceshigh_server.rb druby://localhost:12345
# druby://localhost:12345

uri = ARGV.shift
DRb.start_service(uri, Aces::High::SearchEngine.new)
puts DRb.uri
DRb.thread.join()