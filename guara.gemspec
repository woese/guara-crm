# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guara/version"

Gem::Specification.new do |s|
  s.name        = "guara"
  s.version     = Guara::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Base Enterprise Application"
  s.email       = "ti@woese.com"
  s.homepage    = "http://guara.woese.com"
  s.description = "Base Enterprise Application"
  s.authors     = ['Bruno Guerra']

  s.rubyforge_project = "guara"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency("formtastic", "~> 2.2.1")
  s.add_dependency("formtastic-bootstrap", "~> 2.0.0")

  s.add_dependency("will_paginate", "~> 3.0.3")
  s.add_dependency("devise", "~> 2.1.2")
  s.add_dependency("cancan", "~> 1.6.8")
  s.add_dependency("jquery-rails", "~> 2.1.3")
  
  s.add_dependency("meta_search", "~> 1.1.3")
  
  s.add_dependency("bcrypt-ruby", "~> 3.0")
  s.add_dependency("railties", "~> 3.1")
end