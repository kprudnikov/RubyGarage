# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'CodeBreaker/version'

Gem::Specification.new do |spec|
  spec.name          = "CodeBreaker"
  spec.version       = CodeBreaker::VERSION
  spec.authors       = ["kprudnikov"]
  spec.email         = ["kprudnikov@gmail.com"]

  spec.summary       = %q{Code breaker game.}
  spec.description   = %q{Code breaker game.}
  spec.homepage      = "https://github.com/kprudnikov/RubyGarage/tree/master/CodeBreaker"
  spec.license       = "MIT"
  spec.files = ["../lib/CodeBreaker/game.rb", "../lib/CodeBreaker/interface.rb"]

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|.gem)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end