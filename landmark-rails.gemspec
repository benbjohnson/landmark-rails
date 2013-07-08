$:.push File.expand_path("../lib", __FILE__)

require "landmark/rails/version"

Gem::Specification.new do |s|
  s.name        = "landmark-rails"
  s.version     = Landmark::Rails::VERSION
  s.authors     = ["Ben Johnson"]
  s.email       = ["ben@skylandlabs.com"]
  s.homepage    = "http://landmark.io"
  s.summary     = "Rails integration for the Landmark analytics service."
  s.description = "Rails integration for the Landmark analytics service."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
end
