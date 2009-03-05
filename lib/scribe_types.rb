#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#
require File.dirname(__FILE__) + '/fb303_types'


module ResultCode
  OK = 0
  TRY_LATER = 1
  VALID_VALUES = Set.new([OK, TRY_LATER]).freeze
end

class LogEntry
  include ::Thrift::Struct
  CATEGORY = 1
  MESSAGE = 2

  Thrift::Struct.field_accessor self, :category, :message
  FIELDS = {
    CATEGORY => {:type => Thrift::Types::STRING, :name => 'category'},
    MESSAGE => {:type => Thrift::Types::STRING, :name => 'message'}
  }

  def struct_fields; FIELDS; end

  def validate
  end

end

