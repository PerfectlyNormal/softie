# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'softie/version'

Gem::Specification.new do |spec|
  spec.name          = "softie"
  spec.version       = Softie::VERSION
  spec.authors       = ["Per Christian B. Viken"]
  spec.email         = ["perchr@northblue.org"]
  spec.summary       = %q{MongoMapper plugin that adds soft-delete functionality}
  spec.description   = %q{Softie adds soft-delete functionality to MongoMapper documents with minimal fuss}
  spec.homepage      = "https://github.com/PerfectlyNormal/softie"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.specification_version = 3
  spec.add_runtime_dependency     "mongo_mapper", ">= 0.9.0"
  spec.add_development_dependency "rspec",        "~> 2.11"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "timecop"
end
