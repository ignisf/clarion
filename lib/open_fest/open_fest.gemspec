$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "open_fest/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "open_fest"
  s.version     = OpenFest::VERSION
  s.authors     = ["Petko Bordjukov"]
  s.email       = ["bordjukov@gmail.com"]
  s.summary     = "OpenFest CFP User-facing part"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "devise", ">= 0"
  s.add_dependency "font-awesome-sass", ">= 0"

  s.add_development_dependency "sqlite3"
end
