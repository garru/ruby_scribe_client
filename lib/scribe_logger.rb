#convenience wrapper for scribe
require File.dirname(__FILE__) + '/scribe'

class ScribeLogger
  attr_accessor :host, :port
  
  def initialize(host, port)
    @transport = Thrift::FramedTransport.new(Thrift::Socket.new(host, port))
    @protocol = Thrift::BinaryProtocol.new(@transport, false, false)
    @client = Scribe::Client.new(@protocol)
  end
  
  def []=(category, message)
    log(category, message)
  end
  
  def log(category, message)
    begin
      log_entry = LogEntry.new({:category => category, :message => message})
      @transport.open()
      result = @client.Log([log_entry])
      @transport.close()
      return result
    rescue  Thrift::Exception => tx
      print 'Thrift::Exception: ', tx.message, "\n"
    end    
  end
end