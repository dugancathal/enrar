require "enrar/version"
require 'pathname'

require 'active_record'
require 'active_support/core_ext/string'

require 'rake'

require 'enrar/db'
require 'enrar/migrator'
require 'enrar/migration'
require 'enrar/schema'

module Enrar
  def self.env
    @@env ||= (ENV['ENRAR_ENV'] || 'development')
  end

  def self.gem_root
    @@gem_root ||= Pathname(File.expand_path('../', __FILE__))
  end

  def self.db_config
    @@db_config ||= root.join('config', 'database.yml')
  end

  def self.root=(path)
    @@root = Pathname(path)
  end

  def self.root
    @@root ||= begin
      root_path = Dir.pwd

      while not_in_a_project_root?(root_path)
        parent = File.dirname(root_path)
        root_path = parent != root_path && parent
      end

      root = File.exist?("#{root_path}/#{flag}") ? root_path : nil
      raise "Could not find root path for #{self}" unless root

      RbConfig::CONFIG['host_os'] =~ /mswin|mingw/ ?
        Pathname.new(root).expand_path : Pathname.new(root).realpath
    end
  end

  def self.not_in_a_project_root?(root_path)
    root_path && File.directory?(root_path) && !File.exist?("#{root_path}/#{flag}")
  end

  def self.clear_config!
    @@env = nil
    @@root = nil
    @@db_config = nil
    @@rake_tasks = nil
  end

  # This is a file that designates the top-level of a project
  def self.flag
    'Gemfile'
  end

  def self.initialize!
    ActiveRecord::Base.configurations = YAML::load_file(db_config.to_s)
    ActiveRecord::Base.establish_connection ActiveRecord::Base.configurations[env]
    true
  end

  def self.setup!
    initialize!
    ActiveRecord::Base.connection
  end
end
