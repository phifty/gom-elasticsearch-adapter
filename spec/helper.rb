require 'rubygems'
gem 'rspec', '>= 2'
require 'rspec'

require 'gom/spec'
require 'gom/couchdb-adapter'

require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "gom", "elasticsearch-adapter"))
require File.join(File.dirname(__FILE__), "storage_configuration")
