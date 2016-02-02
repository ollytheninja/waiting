# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'waiting/version'

Gem::Specification.new do |spec|
  spec.name          = 'waiting'
  spec.version       = Waiting::VERSION
  spec.authors       = ['Henry Muru Paenga']
  spec.email         = ['henry.murupaenga@xero.com']

  spec.summary       = "Waits so you don't have too!"
  spec.description   = "Waits so you don't have too!"
  spec.homepage      = 'https://github.com/meringu/waiting'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
