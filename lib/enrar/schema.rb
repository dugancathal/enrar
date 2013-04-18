require 'enrar'

module Enrar
  class Schema
    def version
      ActiveRecord::Migrator.current_version
    end
  end
end
