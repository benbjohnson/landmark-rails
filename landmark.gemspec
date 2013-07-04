$:.push File.expand_path("../lib", __FILE__)

require "landmark/version"

Gem::Specification.new do |s|
  s.name        = "landmark"
  s.version     = Landmark::VERSION
  s.authors     = ["Ben Johnson"]
  s.email       = ["ben@skylandlabs.com"]
  s.homepage    = "http://landmark.io"
  s.summary     = "Client library for the Landmark analytics service."
  s.description = "Client library for the Landmark analytics service."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
end
