
module GOM::Storage::ElasticSearch

  autoload :Adapter, File.join(File.dirname(__FILE__), "elastic_search", "adapter")
  autoload :Collection, File.join(File.dirname(__FILE__), "elastic_search", "collection")
  autoload :CouchDB, File.join(File.dirname(__FILE__), "elastic_search", "couchdb")
  autoload :Draft, File.join(File.dirname(__FILE__), "elastic_search", "draft")

end
