$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "record_formatter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "record_formatter"
  s.version     = RecordFormatter::VERSION
  s.authors     = ["Tomasz Skorupa"]
  s.summary     = "RecordFormatter plucks columns from records given a scope"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.8"
  s.required_ruby_version = '>= 2.1.3'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "mocha"
end
