#!/usr/bin/env ruby
require 'lib/scribe_logger'
begin
  port = 1463
  puts ARGV.inspect
  if ARGV.size == 1
    category = ARGV[0]
    host = '127.0.0.1'
    port = 1463
  elsif ARGV.size == 3 && ARGV[0] == '-h'
    category = ARGV[1]
    host_port = ARGV[2].split(":")
    host = host_port[0]
    port = host_port.size > 1 ? port = host_port[1].to_i : 1463
  else
    puts "usage (message is stdin): scribe_cat [-h host[:port]] category"
  end
  entry = STDIN.read
  client = ScribeLogger.new(host, port)
  client[category] = entry
rescue Thrift::Exception => tx
  print 'Thrift::Exception: ', tx.message, "\n"
end
