# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby_scribe_client}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gary Tsang"]
  s.date = %q{2009-03-30}
  s.description = %q{Ruby Scribe Client. Package and Wrapper for generated ruby interfaces}
  s.email = %q{}
  s.extra_rdoc_files = ["CHANGELOG", "lib/ruby_scribe_client/FacebookService.rb", "lib/ruby_scribe_client/fb303_types.rb", "lib/ruby_scribe_client/reflection_limited_types.rb", "lib/ruby_scribe_client/scribe.rb", "lib/ruby_scribe_client/scribe_types.rb", "lib/ruby_scribe_client.rb", "LICENSE", "README"]
  s.files = ["CHANGELOG", "etc/scribe_cat.rb", "lib/ruby_scribe_client/FacebookService.rb", "lib/ruby_scribe_client/fb303_types.rb", "lib/ruby_scribe_client/reflection_limited_types.rb", "lib/ruby_scribe_client/scribe.rb", "lib/ruby_scribe_client/scribe_types.rb", "lib/ruby_scribe_client.rb", "LICENSE", "Manifest", "Rakefile", "README", "ruby_scribe_client.gemspec", "vendor/thrift/client.rb", "vendor/thrift/deprecation.rb", "vendor/thrift/exceptions.rb", "vendor/thrift/processor.rb", "vendor/thrift/protocol/binaryprotocol.rb", "vendor/thrift/protocol/binaryprotocolaccelerated.rb", "vendor/thrift/protocol/tbinaryprotocol.rb", "vendor/thrift/protocol/tprotocol.rb", "vendor/thrift/protocol.rb", "vendor/thrift/serializer.rb", "vendor/thrift/server/httpserver.rb", "vendor/thrift/server/nonblockingserver.rb", "vendor/thrift/server/thttpserver.rb", "vendor/thrift/server/tserver.rb", "vendor/thrift/server.rb", "vendor/thrift/struct.rb", "vendor/thrift/thrift.rb", "vendor/thrift/transport/httpclient.rb", "vendor/thrift/transport/socket.rb", "vendor/thrift/transport/thttpclient.rb", "vendor/thrift/transport/tsocket.rb", "vendor/thrift/transport/ttransport.rb", "vendor/thrift/transport/unixsocket.rb", "vendor/thrift/transport.rb", "vendor/thrift/types.rb", "vendor/thrift.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/garru/ruby_scribe_client}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Ruby_scribe_client", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ruby_scribe_client}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Ruby Scribe Client. Package and Wrapper for generated ruby interfaces}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
