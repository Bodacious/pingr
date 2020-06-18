# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pingr/version'

Gem::Specification.new do |gem|
  gem.name          = 'pingr'
  gem.version       = Pingr::VERSION
  gem.authors       = ['Bodacious']
  gem.email         = ['bodacious@katanacode.com']
  gem.description   = 'A simple gem for pinging search engines with your XML sitemap'
  gem.summary       = 'Ping search engines with your XML Sitemap'
  gem.homepage      = 'https://github.com/KatanaCode/pingr'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'dotenv'
  gem.add_runtime_dependency 'rake'
  
  gem.add_development_dependency 'rspec'
end
