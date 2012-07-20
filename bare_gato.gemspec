# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bare_gato/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["emmanuel delgado"]
  gem.email         = ["emmanuel.delgado@crowdint.com"]
  gem.description   = %q{A tic tac toe game engine}
  gem.summary       = %q{A tic tac toe game engine}
  gem.homepage      = "http://emmanueldelgado.me"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "bare_gato"
  gem.require_paths = ["lib"]
  gem.version       = BareGato::VERSION

  gem.add_development_dependency 'rspec'
end
