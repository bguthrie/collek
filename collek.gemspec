# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'collek/version'

Gem::Specification.new do |spec|
  spec.name          = "collek"
  spec.version       = Collek::VERSION
  spec.authors       = ["Brian Guthrie"]
  spec.email         = ["btguthrie@gmail.com"]
  spec.description   = %q{Perform simple data mapping and transformation.}
  spec.summary       = %q{Perform simple data mapping and transformation.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
