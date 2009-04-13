#convenience wrapper for scribe
require File.join([File.dirname(__FILE__), 'ruby_scribe_client', 'scribe'])

class ScribeLogger
  attr_accessor :host, :port, :namespace
  
  def initialize(host, port, namespace = nil, timeout = nil)
    @transport = Thrift::FramedTransport.new(Thrift::Socket.new(host, port, timeout))
    @protocol = Thrift::BinaryProtocol.new(@transport, false, false)
    @client = Scribe::Client.new(@protocol)
    @namespace = namespace
  end
  
  def []=(category, message)
    log(category, message)
  end
  
  def log(category, message)
    begin
      log_entry = LogEntry.new({:category => category_key(category), :message => message.to_s})
      connect
      result = @client.Log([log_entry])
      # @transport.flush
      return result
    rescue  Thrift::Exception => tx
      raise tx
    end    
  end
  
  def connect
    @transport.open unless @transport.open?
  end
  
  def disconnect
    @transport.close if @transport.open?
  end
  
  def category_key(category)
   [@namespace, category].compact.join('_')
  end
end