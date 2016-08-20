module Smarticle
  class Engine < ::Rails::Engine
    require 'rubygems'
    require 'paperclip'

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
