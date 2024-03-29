require 'enrar'
require 'rake'
require 'rake/tasklib'

module Enrar

  # Create the Enrar Rake tasks programmatically.
  # This code was shamelessly stolen and modified from the Rake library.
  class Task < Rake::TaskLib

    # Name of test task. (default is :enrar)
    attr_accessor :name

    # The path to your database.yml file. (default is config/database.yml)
    attr_accessor :database_config
 
    # Do you want me to be noisy?
    attr_accessor :verbose

    # Create the Enrar tasks
    def initialize(name=:enrar)
      @name = name
      @database_config = 'config/database.yml'
      @verbose = verbose
      yield self if block_given?
      define
    end

    # Create the tasks defined by this task lib.
    def define
      desc "Generate a migration (don't forget to pass the migration name)"
      task "#{@name}:migrations:generate", [:name] do |t, args|
        raise 'Need a migration name' unless args[:name]
        Enrar::Migration.new(args[:name]).generate!
      end

      desc "Create the db"
      task "#{@name}:db:create" do
        Enrar::DB.new.create!
      end

      desc "Migrate the database (VERBOSE=true)"
      task "#{@name}:db:migrate", [:version] do |t, args|
        Enrar::Migrator.new(args[:version], verbose: ENV['VERBOSE']).migrate!
      end
      self
    end
  end
end
