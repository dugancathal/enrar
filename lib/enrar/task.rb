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
      desc "Generate a migration. Don't forget to pass the migration name"
      task "#{@name}:migrations:generate", [:name] do |t, args|
        Enrar::Migration.new(args[:name]).generate!
      end
      self
    end
  end
end
