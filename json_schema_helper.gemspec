# frozen_string_literal: true

lib = File.expand_path('./lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_schema_helper/version'

Gem::Specification.new do |s|
  s.name          = 'json_schema_helper'
  s.version       = JsonSchemaHelper::VERSION
  s.authors       = ['Yoshiyuki Hirano']
  s.email         = ['yhirano@me.com']
  s.homepage      = 'https://github.com/yhirano55/json_schema_helper'
  s.summary       = %(json schema helper)
  s.description   = s.summary
  s.license       = 'MIT'
  s.files         = Dir.chdir(File.expand_path('.', __dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  s.bindir        = 'exe'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_rubygems_version = '>= 1.8.11'

  s.add_development_dependency 'bundler', '~> 2.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
end
