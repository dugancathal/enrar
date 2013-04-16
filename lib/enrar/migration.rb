require 'erb'

module Enrar
  class Migration
    attr_reader :migration_class_name

    def initialize(name)
      @migration_class_name = name.underscore.classify
    end

    def generate!
      FileUtils.mkdir_p path.dirname
      File.write(path.to_s, ERB.new(TEMPLATE).result(binding))
    end

    def path
      Enrar.root.join('db/migrate', filename)
    end

    def filename
      "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{@migration_class_name.underscore}.rb"
    end

    TEMPLATE = <<-MIGRATION.strip_heredoc
      class <%= @migration_class_name %> < ActiveRecord::Migration
        def change
          # insert your migration stuffs here
        end
      end
    MIGRATION
  end
end
