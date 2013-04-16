require "enrar/version"
require 'pathname'

module Enrar
  def self.project_root
    @@project_root ||= Pathname(File.expand_path('../', __FILE__))
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
end
