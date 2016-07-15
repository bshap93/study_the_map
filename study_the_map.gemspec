# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'study_the_map/version'

Gem::Specification.new do |spec|
  spec.name          = "study_the_map"
  spec.version       = StudyTheMap::VERSION
  spec.authors       = ["bshap93"]
  spec.email         = ["benihana858@gmail.com"]

  spec.summary       = "A Ski Map Fetcher"
  spec.description   = "This gem will gather skiing trail maps from skimap.org, allowing you to find and download maps from sites for resorts across the world."
  spec.homepage      = "https://github.com/bshap93/study_the_map"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "launchy"
  spec.add_runtime_dependency "nokogiri"
end
