require 'aces_high'
# [Terminal server with jruby]
# jruby aceshigh_server.rb druby://localhost:12345
# druby://localhost:12345

uri = ARGV.shift
DRb.start_service(uri, AcesHigh.new)
puts DRb.uri
DRb.thread.join()