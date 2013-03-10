# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'locale_setter/version'

Gem::Specification.new do |gem|
  gem.name          = "locale_setter"
  gem.version       = LocaleSetter::VERSION
  gem.authors       = ["Jeff Casimir"]
  gem.email         = ["jeff@casimircreative.com"]
  gem.description   = "Automatically set per-request locale in Rails applications"
  gem.summary       = "Automatically set per-request locale in Rails applications"
  gem.homepage      = "http://github.com/jcasimir/locale_setter"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake", "~>10.0.3"
  gem.add_development_dependency "rspec", "~>2.13.0"
end
