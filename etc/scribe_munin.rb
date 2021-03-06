#! /usr/bin/env ruby
# Munin plugin for starling.
HOST = ENV['HOST'] || '127.0.0.1';
PORT = ENV['PORT'] || 1463;
require 'rubygems'
require 'ruby_scribe_client'

#Monkey patched so the namespaced queues are included in stats
class ScribeStats
  CATEGORY = 'scribe'

  def initialize(host, port)
    @scribe = FB303::Client.new(host, port)
    @category = 'scribe'
  end


  def net_stats
    stats = {
        :label => 'read',
        :type => 'COUNTER',
        :graph => 'no',
        :cdef => '8,*'
    }
    return stats
  end

  def net_munin_config
    graph_config = <<-END.gsub(/  +/, '')
      graph_title Scribe Traffic
      graph_args --base 1000
      graph_vlabel bits per second
      graph_category #{CATEGORY}
      graph_order bytes_read bytes_written
    END

    stat_config = ''
    counters.keys.each do |stat|
      stat_name = stat.gsub(/\s/){'_'}
      net_stats.each do |var,value|
        value = "#{stat_name}," + value if var == :cdef
        stat_config << "#{stat_name}.#{var} #{value}\n"
      end
    end

    return graph_config + stat_config
  end

  def net_munin
    ret = ""
    @scribe.getCounters.each do |k, v|
      ret << "#{k.gsub(/\s/){'_'}}.value #{v}\n"
    end
    ret
  end
    
private  

  def munin_name(str)
    str.tr(":", '_')
  end
  
  
  
  def counters
    @scribe.getCounters
  end
  
end

# We pick the chart based on the command we were called as.
if $0 =~ /scribe_(\w+)/ then
  chart_name = $1
else
  $stderr.puts "can't find chart name"
end

starling = ScribeStats.new(HOST, PORT)

command = "#{chart_name}_munin"

if ARGV[0] == 'config' then
  command << '_config'
end

print starling.send(command)