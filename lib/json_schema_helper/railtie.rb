# frozen_string_literal: true

module JsonSchemaHelper
  class Railtie < ::Rails::Railtie # :nodoc:
    rake_tasks do
      load 'json_schema_helper/tasks/init.rake'
      load 'json_schema_helper/tasks/update.rake'
    end
  end
end
