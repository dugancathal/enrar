require "enrar/version"
require 'pathname'

module Enrar
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

      while root_path && File.directory?(root_path) && !File.exist?("#{root_path}/#{flag}")
        parent = File.dirname(root_path)
        root_path = parent != root_path && parent
      end

      root = File.exist?("#{root_path}/#{flag}") ? root_path : default
      raise "Could not find root path for #{self}" unless root

      RbConfig::CONFIG['host_os'] =~ /mswin|mingw/ ?
        Pathname.new(root).expand_path : Pathname.new(root).realpath
    end
  end

  # This is a file that designates the top-level of a project
  def self.flag
    'Gemfile'
  end
end
