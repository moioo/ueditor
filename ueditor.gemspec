$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ueditor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ueditor"
  s.version     = Ueditor::VERSION
  s.authors     = ["moioo"]
  s.email       = ["moioo@qq.com"]
  s.homepage    = "http://ueditor.baidu.com"
  s.summary     = "ueditor."
  s.description = "ueditor."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", ['>= 5.2.0', '< 8.0']

  #s.add_development_dependency "sqlite3"
end
