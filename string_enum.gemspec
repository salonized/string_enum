# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'string_enum/version'

Gem::Specification.new do |spec|
  spec.name          = "string_enum"
  spec.version       = StringEnum::VERSION
  spec.authors       = ["Danny Hiemstra"]
  spec.email         = ["danny@salonized.com"]

  spec.summary       = %q{Use a string field as enum}
  spec.description   = %q{This gem will take care of scopes, validations and normalization}
  spec.homepage      = "https://www.salonized.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", [">= 3.0"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
