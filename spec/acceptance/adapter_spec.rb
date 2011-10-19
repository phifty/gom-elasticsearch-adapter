require File.expand_path(File.join(File.dirname(__FILE__), "..", "helper"))

describe "couchdb adapter" do

  it_should_behave_like "an adapter with search view"

end
