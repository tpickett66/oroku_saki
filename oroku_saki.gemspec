# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oroku_saki/version'

Gem::Specification.new do |spec|
  spec.name          = "oroku_saki"
  spec.version       = OrokuSaki::VERSION
  spec.authors       = ["Tyler Pickett"]
  spec.email         = ["t.pickett66@gmail.com"]

  spec.summary       = %q{OrokuSaki, a.k.a. Shredder, is the destroyer of strings and attacker's worst nightmare!}
  spec.description   = "OrokuSaki, a.k.a. Shredder, is a small collection of " \
    "utilities for ensuring the strings used in cryptographic operations " \
    "remain secret. This currently includes memory zeroing and constant time " \
    "String comparisons."
  spec.homepage      = "https://github.com/tpickett66/oroku_saki"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/oroku_saki/extconf.rb"]

  spec.add_development_dependency "bundler", "~> 2.2.33"
  spec.add_development_dependency "rake", "~> 12.3.2"
  spec.add_development_dependency "rake-compiler", "~> 0.9"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug", "~> 8.2"
  spec.add_development_dependency "yard", "~> 0.9.11"
end
