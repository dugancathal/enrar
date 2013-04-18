require 'enrar'

module Enrar
  class DB
    def initialize
    end

    def create!
      FileUtils.mkdir_p path
      ActiveRecord::Base.connection
    end

    def path
      Enrar.root.join('db').to_s
    end
  end
end
