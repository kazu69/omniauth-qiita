# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/qiita/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-qiita"
  spec.version       = Omniauth::Qiita::VERSION
  spec.authors       = ["kazu69"]
  spec.email         = ["kazu.69.web+omniauth_qiita@gmail.com"]
  spec.summary       = %q{OmniAuth strategy for qiita}
  spec.description   = %q{OmniAuth strategy for qiita}
  spec.homepage      = "https://github.com/kazu69/omniauth-qiita"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 1.0"
  spec.add_dependency "omniauth-oauth2", "~> 1.1"
  spec.add_dependency "oauth2", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
end
