# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trelloid/version'

Gem::Specification.new do |gem|
  gem.name          = "trelloid"
  gem.version       = Trelloid::VERSION
  gem.authors       = ["Stratos Voukelatos"]
  gem.email         = ["stratosvoukel@gmail.com"]
  gem.description   = %q{Trello automation DSL}
  gem.summary       = %q{Use trello as an task doer}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-mocks"
  gem.add_development_dependency "simplecov"

  gem.add_dependency "ruby-trello"
  gem.add_dependency "activesupport"
  gem.add_dependency "celluloid"

end
