require 'tire'

# The ElasticSearch storage adapter.
class GOM::Storage::ElasticSearch::Adapter < GOM::Storage::Adapter

  attr_reader :storage_configuration

  def setup
    setup_connection
    setup_index
    assign_storage
    setup_river
  end

  def teardown
    
  end

  def fetch(id)
    storage_adapter.fetch id
  end

  def store(draft)
    storage_adapter.store draft
  end

  def remove(id)
    storage_adapter.remove id
  end

  def collection(name, options = { })
    view = configuration.views[name.to_sym]
    raise ArgumentError, "the given view #{name} isn't defined!'" unless view

    query_string = build_query view.class_name, options[:query]
    search = Tire.search @index_name do
      query { string query_string }
    end

    GOM::Object::Collection.new GOM::Storage::ElasticSearch::Collection::Fetcher.new(search.results), configuration.name
  end

  private

  def storage_adapter
    storage_configuration.adapter
  end

  def setup_connection
    @host, @port = *configuration.values_at(:host, :port)
    @host ||= "localhost"
    @port ||= 9200

    # Tire.configure { url "http://#{@host}:#{@port}" }
  end

  def setup_index
    @index_name, delete_index_if_exists, create_index_if_missing =
      *configuration.values_at(:index_name, :delete_index_if_exists, :create_index_if_missing)

    Tire.index @index_name do
      delete if delete_index_if_exists && exists?
      create if create_index_if_missing && !exists?
    end
  end

  def assign_storage
    assign_to_storage = configuration[:assign_to_storage]

    @storage_configuration = GOM::Storage::Configuration[assign_to_storage]
    raise ArgumentError, "the specified storage #{assign_to_storage} doesn't exists" unless @storage_configuration
  end

  def setup_river
    delete_river_if_exists, create_river_if_missing =
      *configuration.values_at(:delete_river_if_exists, :create_river_if_missing)

    river = GOM::Storage::ElasticSearch::CouchDB::River.new :couch_db => storage_configuration,
                                                            :elastic_search => {
                                                              :host => @host,
                                                              :port => @port,
                                                              :index_name => @index_name
                                                            }

    river.delete_if_exists if delete_river_if_exists
    river.create_if_missing if create_river_if_missing
  end

  def build_query(model_class, query)
    terms = [ model_class ].flatten.compact.map{ |klass| "model_class:\"#{klass}\"" }
    "(#{terms.join(" OR ")})" + (query && query != "" ? " AND #{query}" : "")
  end

end
