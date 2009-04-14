require File.join([File.dirname(__FILE__), 'scribe'])
require File.join([File.dirname(__FILE__), '..', '..', 'vendor','thrift','server','nonblockingserver'])
# 
# class ScribeHandler
#   def Log(messages)
#     messages.each do |x|
#       puts "#{x.inspect}"
#     end
#     return ResultCode::OK
#   end
# end
# 
# handler = ScribeHandler.new
# 
# puts "Starting the server..."
# server.serve()
# puts "done."
class ScribeServer
  def initialize(port, handler)
    handler
    processor = Scribe::Processor.new(handler)
    transport = Thrift::ServerSocket.new(port)
    transportFactory = Thrift::FramedTransportFactory.new
    @server = Thrift::NonblockingServer.new(processor, transport, transportFactory)  
  end
  
  def run
    @server.serve()
  end
end

# class ScribeHandler
#   def Log(messages)
#     messages.each do |x|
#       puts "#{x.inspect}"
#     end
#     return ResultCode::OK
#   end
# end  
# 
# a = ScribeServer.new(1501, ScribeHandler.new)
# a.run