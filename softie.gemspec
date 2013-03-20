# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'softie/version'

Gem::Specification.new do |spec|
  spec.name          = "softie"
  spec.version       = Softie::VERSION
  spec.authors       = ["Per Christian B. Viken"]
  spec.email         = ["perchr@northblue.org"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{MongoMapper plugin that adds soft-delete functionality}
  spec.homepage      = "https://eastblue.org/blag/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
