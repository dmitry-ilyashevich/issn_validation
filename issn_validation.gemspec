# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "issn_validation/version"

Gem::Specification.new do |s|
  s.name    = "issn_validation"
  s.version = IssnValidation::VERSION
  s.summary = "issn_validation adds an issn validation routine to active record models."
  s.authors = ["Dmitry A. Ilyashevich"]
  s.email   = ["dmitry.ilyashevich@gmail.com"]
  s.description = "issn_validation adds an issn validation routine to active record models."
  s.homepage = 'https://github.com/dmitry-ilyashevich/issn_validation'

  s.extra_rdoc_files = %w(README.md MIT-LICENSE)
  s.files            = Dir.glob("lib/**/*") + %w(README.md MIT-LICENSE)

  s.add_dependency(%q<activerecord>, [">= 3"])
  s.add_development_dependency("sqlite3")
end

