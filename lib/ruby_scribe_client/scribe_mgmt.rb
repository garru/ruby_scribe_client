require File.join([File.dirname(__FILE__), '..', '..', 'vendor','thrift'])
require File.join([File.dirname(__FILE__) ,'FacebookService'])
require File.join([File.dirname(__FILE__), 'scribe_types'])
require 'optparse'
require 'rubygems'

class FB303
  attr_accessor :client
  
  COMMAND_MAP = { :reload => 'reinitialize',
    :stop => 'shutdown',
    :version => 'getVersion',
    :name => 'getName',
    :alive => 'aliveSince'
  }
   
  STATUS = {
     Fb_status::DEAD => "DEAD",
     Fb_status::STARTING => "STARTING",
     Fb_status::ALIVE => "ALIVE",
     Fb_status::STOPPING => "STOPPING",
     Fb_status::STOPPED => "STOPPED",
     Fb_status::WARNING => "WARNING"
  }
  
  def initialize(port)
    @transport = Thrift::FramedTransport.new(Thrift::Socket.new('localhost', port))
    @protocol = Thrift::BinaryProtocol.new(@transport, false, false)
    @client = FacebookService::Client.new(@protocol)
  end

  def method_missing(method)
    if COMMAND_MAP.has_key?(method)
      if [:version, :alive, :name].include?(method)
        result = self.send(COMMAND_MAP[method])
        puts result
      elsif [:stop, :reload].include?(method)
        result = self.send(COMMAND_MAP[method])
            puts result
      end
    elsif @client.respond_to?(method)
      @transport.open
      return @client.send(method)
      @transport.close
    else
      require 'ruby-debug'; debugger
      raise NoMethodError.new;
    end
  end
  
  def status
    status = self.getStatus
    status_details = self.getStatusDetails || ""
    msg = fb_status_string(status)
    msg += " - %s" % status_details if status_details.size > 0
    puts msg
    return (status == Fb_status::ALIVE) ? 2 : 3    
  end
  
  def counters
    # require 'ruby-debug'; debugger
    self.getCounters.each_pair do |key, value|
      puts "%s: %d" % [key, value]
    end
  end
  
  def fb_status_string(status_code)
    STATUS[status_code]
  end
end

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
