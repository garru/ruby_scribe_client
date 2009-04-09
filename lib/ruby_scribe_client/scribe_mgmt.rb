require File.join([File.dirname(__FILE__), '..', '..', 'vendor','thrift'])
require File.join([File.dirname(__FILE__) ,'FacebookService'])
require File.join([File.dirname(__FILE__), 'scribe_types'])
require File.join([File.dirname(__FILE__) ,'fb303_client'])
require 'optparse'
require 'rubygems'

options = {}

begin

OptionParser.new do |opts|
  opts.banner = "Usage: scribe_mgmt.rb [options]"
  options[:port] = 9082
  options[:command] = 'status'
  opts.on("-c", "--command [TYPE]", ["stop","counters","status","reload","version","name","alive"], "execute this API (#{["stop","counters","status","reload","version","name","alive"].join(" ")})") do |v|
    options[:command] = v
  end
  
  opts.on("-p", "--port #", Integer, "this service's port (default 9082)") do |port|
    options[:port] = port
  end
end.parse!

rescue OptionParser::ParseError => e
  puts e.message
  Process.exit
end

a = FB303.new(options[:port])
a.send(options[:command])
