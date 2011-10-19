require 'transport'

class GOM::Storage::ElasticSearch::CouchDB::River

  def initialize(options)
    @couch_db = options[:couch_db]
    @elastic_search = options[:elastic_search]
  end

  def create
    Transport::JSON.request :put, "#{elastic_search_base_url}/_river/#{@elastic_search[:index_name]}/_meta",
                            :body => {
                              :type => "couchdb",
                              :couchdb => {
                                :host => @couch_db[:host],
                                :port => @couch_db[:port],
                                :db => @couch_db[:database],
                                :user => @couch_db[:username],
                                :password => @couch_db[:password]
                              },
                              :index => {
                                :index => @elastic_search[:index_name],
                                :type => @elastic_search[:index_name],
                                :bulk_size => "100",
                                :bulk_timeout => "10ms"
                              }
                            },
                            :expected_status_code => [ 200, 201 ]
  end

  def create_if_missing
    create unless exists?
  end

  def delete
    Transport::JSON.request :delete, "#{elastic_search_base_url}/_river/#{@elastic_search[:index_name]}", :expected_status_code => 200
  end

  def delete_if_exists
    delete if exists?
  end

  def exists?
    Transport::JSON.request :get, "#{elastic_search_base_url}/_river/#{@elastic_search[:index_name]}/_meta", :expected_status_code => 200
    true
  rescue Transport::UnexpectedStatusCodeError
    false
  end

  private

  def elastic_search_base_url
    "http://#{@elastic_search[:host]}:#{@elastic_search[:port]}"
  end

end
