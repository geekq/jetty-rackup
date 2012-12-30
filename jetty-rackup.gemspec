# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jetty-rackup/version'

Gem::Specification.new do |gem|
  gem.name          = "jetty-rackup"
  gem.version       = Jetty::Rackup::VERSION
  gem.authors       = ["Vladimir Dobriakov", "Leandro Silva", "Jason Rogers"]
  gem.email         = ["vladimir@geekq.net"]
  gem.description   = %q{Runs a rack conform application inside jetty web server}
  gem.summary       = %q{Rack + Jetty = Retty}
  gem.homepage      = %q{http://github.com/geekq/jetty-rackup}

  # Order is important - put this line before all other file related directives
  gem.files         = `git ls-files`.split($/)

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }

  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.require_paths = ["lib"]

  gem.rubygems_version = %q{1.3.6}

  gem.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]

  gem.add_dependency 'rack'

  # bundler 1.2.3 seems to ignore the dependency defined by the following code line.
  # So for development/testing just install sinatra with `gem install sinatra`.
  # Or should I better put it under the :development group in the Gemfile like:
  # gem 'sinatra', :group => :development
  gem.add_development_dependency 'sinatra'

end

