# frozen_string_literal: true

require 'fileutils'

namespace :openapi3 do
  desc 'init'
  task init: :environment do
    FileUtils.mkdir_p Rails.root.join('docs', 'openapi3', 'paths')
    FileUtils.mkdir_p Rails.root.join('docs', 'openapi3', 'components', 'parameters')
    FileUtils.mkdir_p Rails.root.join('docs', 'openapi3', 'components', 'schemas')

    unless File.exist?('docs/openapi3/meta.yaml')
      File.open('docs/openapi3/meta.yaml', 'wb+') do |io|
        io.write <<~YAML
          openapi: 3.0.0

          info:
            version: 1.0.0
            title: #{Rails.application.class.to_s.deconstantize.titleize}

          servers:
          - url: http://localhost:3000
        YAML
      end
    end

    if Dir['./docs/openapi3/paths/**/*.yaml'].empty?
      File.open('docs/openapi3/paths/v1.yaml', 'wb+') do |io|
        io.write <<~YAML
          # "/v1/admin_users":
          #   get:
          #     responses:
          #       '200':
          #         content:
          #           application/json:
          #             schema:
          #               type: array
          #               items:
          #                 "$ref": "#/components/schemas/admin_user/properties/admin_user"
          #     parameters:
          #     - name: access_token
          #       in: query
          #       schema:
          #         "$ref": "#/components/schemas/access_token"
        YAML
      end
    end

    if Dir['./docs/openapi3/components/parameters/**/*.yaml'].empty?
      File.open('docs/openapi3/components/parameters/v1.yaml', 'wb+') do |io|
        io.write <<~YAML
          # v1_something__cursor:
          #   name: cursor
          #   in: query
          #   schema:
          #     nullable: true
          #     type: string
          #     format: date-time
        YAML
      end
    end

    if Dir['./docs/openapi3/components/schemas/**/*.yaml'].empty?
      File.open('docs/openapi3/components/schemas/v1.yaml', 'wb+') do |io|
        io.write <<~YAML
          # access_token:
          #   type: string
          #
          # user_id:
          #   type: integer
          #
          # datetime:
          #   description: datetime
          #   type: string
          #   format: date-time
          #
          # nullable_datetime:
          #   description: datetime
          #   type: string
          #   format: date-time
          #   nullable: true
        YAML
      end
    end
  end
end
