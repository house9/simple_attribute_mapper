# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_attribute_mapper/version'

Gem::Specification.new do |gem|
  gem.name          = "simple_attribute_mapper"
  gem.version       = SimpleAttributeMapper::VERSION
  gem.authors       = ["Jesse House"]
  gem.email         = ["jesse.house@gmail.com"]
  gem.description   = %q{Maps attribute values from one object to another}
  gem.summary       = %q{See the README for more information}
  gem.homepage      = "https://github.com/house9/simple_attribute_mapper"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]


  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'virtus'
end
