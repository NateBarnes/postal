# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "postal/version"

Gem::Specification.new do |s|
  s.name        = "postal"
  s.version     = Postal::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['The Active Network']
  s.email       = ['']
  s.homepage    = ""
  s.summary     = %q{Lyris is an enterprise email service. Postal makes it easy for Ruby to talk to Lyris's API.}
  s.description = %q{Lyris is an enterprise email service. Postal makes it easy for Ruby to talk to Lyris's API.}

  s.rubyforge_project = "postal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('savon', '~>0.9.7')
end
