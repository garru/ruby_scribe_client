require File.join([File.dirname(__FILE__), '..', 'lib', 'ruby_scribe_client'])
a = ScribeLogger.new('localhost', 1463)
a['hi'] = 'people'