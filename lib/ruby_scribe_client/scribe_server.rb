require File.join([File.dirname(__FILE__), 'scribe'])

class ScribeHandler
  def Log(messages)
    messages.each do |x|
      puts "#{x.inspect}"
    end
    return ResultCode::OK
  end
end

handler = ScribeHandler.new
processor = Scribe::Processor.new(handler)
transport = Thrift::ServerSocket.new(1444)
transportFactory = Thrift::FramedTransportFactory.new
server = Thrift::SimpleServer.new(processor, transport, transportFactory)
puts "Starting the server..."
server.serve()
puts "done."