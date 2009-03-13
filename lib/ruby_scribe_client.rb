#convenience wrapper for scribe
require File.join([File.dirname(__FILE__), 'ruby_scribe_client', 'scribe'])

class ScribeLogger
  attr_accessor :host, :port, :namespace
  
  def initialize(host, port, namespace = nil)
    @transport = Thrift::FramedTransport.new(Thrift::Socket.new(host, port))
    @protocol = Thrift::BinaryProtocol.new(@transport, false, false)
    @client = Scribe::Client.new(@protocol)
    @namespace = namespace
  end
  
  def []=(category, message)
    log(category, message)
  end
  
  def log(category, message)
    begin
      log_entry = LogEntry.new({:category => category_key(category), :message => message})
      @transport.open()
      result = @client.Log([log_entry])
      @transport.close()
      return result
    rescue  Thrift::Exception => tx
      print 'Thrift::Exception: ', tx.message, "\n"
    end    
  end
  
  def category_key(category)
   [@namespace, category].compact.join('_')
  end
end