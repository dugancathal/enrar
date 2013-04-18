require 'enrar'

module Enrar
  class Migrator
    def initialize(to_version = nil, options = {})
      @verbose = options[:verbose].nil? ? true : options[:verbose]
      @version = to_version
    end

    def migrate
      ActiveRecord::Migration.verbose = @verbose
      ActiveRecord::Migrator.migrate migrations_dir, @version
    end

    def migrations_dir
      Enrar.root.join('db', 'migrate')
    end
  end
end
