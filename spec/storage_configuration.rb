
GOM::Storage.configure {
  storage {
    name :test_couchdb_storage
    adapter :couchdb
    username "test"
    password "test"
    database "test"
    delete_database_if_exists false
    create_database_if_missing true
  }
  storage {
    name :test_storage
    adapter :elasticsearch
    index_name "test"
    delete_index_if_exists false
    create_index_if_missing true
    delete_river_if_exists false
    create_river_if_missing true
    assign_to_storage :test_couchdb_storage
    view {
      name :test_search_view
      kind :search
      model_class GOM::Spec::Object
    }
  }
}
