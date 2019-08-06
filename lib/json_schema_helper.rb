# frozen_string_literal: true

require 'json_schema_helper/version'

begin
  require 'rails'
  require 'json_schema_helper/railtie'
rescue LoadError
  nil
end
