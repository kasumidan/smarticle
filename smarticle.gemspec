$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smarticle/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smarticle"
  s.version     = Smarticle::VERSION
  s.authors     = ["Kasumi Dan"]
  s.email       = ["xiaoxia.zou@gmail.com"]
  s.homepage    = "http://lynx.life"
  s.summary     = "Make it easy to attach an simple artile to any pages of main app."
  s.description = "Smarticle is responsive!"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["/spec/**/*"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency 'sass-rails'
  s.add_dependency "slim-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "paperclip"
  s.add_dependency "dropzonejs-rails"
  s.add_dependency "font-awesome-rails"
  s.add_dependency 'bootstrap-sass', '~> 3.3.4'
  s.add_dependency 'bootstrap-sass-extras'

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "sqlite3"
end
