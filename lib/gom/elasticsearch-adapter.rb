require 'gom'
require 'gom/couchdb-adapter'
require File.join(File.dirname(__FILE__), "storage")

GOM::Storage::Adapter.register :elasticsearch, GOM::Storage::ElasticSearch::Adapter
