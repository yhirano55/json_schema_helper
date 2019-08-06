# frozen_string_literal: true

namespace :openapi3 do
  desc 'combine YAML files'
  task combine: :environment do
    schema = {}
    schema.merge! YAML.load_file(Rails.root.join('docs', 'openapi3', 'meta.yaml'))

    schema['paths'] = {}

    Dir[Rails.root.join('docs', 'openapi3', 'paths', '**', '*.yaml')].sort.each do |path|
      $stdout.puts "merge #{path}"
      schema['paths'].merge!(YAML.load_file(path) || {})
    rescue StandardError => e
      $stdout.puts "error #{path}: #{e.message}"
      exit
    end

    schema['components'] = {}

    schema['components']['parameters'] = {}
    Dir[Rails.root.join('docs', 'openapi3', 'components', 'parameters', '**', '*.yaml')].sort.each do |path|
      $stdout.puts "merge #{path}"
      schema['components']['parameters'].merge!(YAML.load_file(path) || {})
    rescue StandardError => e
      $stdout.puts "error #{path}: #{e.message}"
      exit
    end

    schema['components']['schemas'] = {}
    Dir[Rails.root.join('docs', 'openapi3', 'components', 'schemas', '**', '*.yaml')].sort.each do |path|
      $stdout.puts "merge #{path}"
      schema['components']['schemas'].merge!(YAML.load_file(path) || {})
    rescue StandardError => e
      $stdout.puts "error #{path}: #{e.message}"
      exit
    end

    schema['paths'] = Hash[schema['paths'].sort_by { |k, _| k }]
    schema['components']['parameters'] = Hash[schema['components']['parameters'].sort_by { |k, _| k }]
    schema['components']['schemas'] = Hash[schema['components']['schemas'].sort_by { |k, _| k }]

    dest = Rails.root.join('docs', 'schema.yaml')

    File.open(dest, 'wb+') do |io|
      io.write YAML.dump(schema)
    end

    $stdout.puts "Update file: #{dest}"
  end

  desc 'verify YAML files'
  task verify: :environment do
    # implement later
  end

  desc 'update schema'
  task update: %w[openapi3:verify openapi3:combine]
end
