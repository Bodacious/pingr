# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pingr/version'

Gem::Specification.new do |gem|
  gem.name          = "pingr"
  gem.version       = Pingr::VERSION
  gem.authors       = ["Bodacious"]
  gem.email         = ["bodacious@katanacode.com"]
  gem.description   = %q{A simple gem for pinging search engines with your XML sitemap}
  gem.summary       = %q{Ping search engines with your XML Sitemap}
  gem.homepage      = "https://github.com/KatanaCode/pingr"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency "rake"
end
