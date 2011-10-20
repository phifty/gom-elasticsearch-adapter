# encoding: utf-8

Gem::Specification.new do |specification|
  specification.name              = "gom-elasticsearch-adapter"
  specification.version           = "0.1.1"
  specification.date              = "2011-10-19"

  specification.authors           = [ "Philipp Brüll" ]
  specification.email             = "b.phifty@gmail.com"
  specification.homepage          = "http://github.com/phifty/gom-elasticsearch-adapter"
  specification.rubyforge_project = "gom-elasticsearch-adapter"

  specification.summary           = "ElasticSearch adapter for the General Object Mapper."
  specification.description       = "ElasticSearch adapter for the General Object Mapper. Current versions of ElasticSearch are supported."

  specification.has_rdoc          = true
  specification.files             = [ "README.rdoc", "LICENSE", "Rakefile" ] + Dir["lib/**/*"] + Dir["spec/**/*"]
  specification.extra_rdoc_files  = [ "README.rdoc" ]
  specification.require_path      = "lib"

  specification.test_files        = Dir["spec/**/*_spec.rb"]

  specification.add_dependency "gom", ">= 0.5.1"

  specification.add_development_dependency "gom-couchdb-adapter", ">= 0.5.0"
  specification.add_development_dependency "rspec", ">= 2"
  specification.add_development_dependency "reek", ">= 1.2"
end
