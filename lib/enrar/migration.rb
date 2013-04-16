module Enrar
  class Migration
    attr_reader :migration_class_name

    def initialize(name)
      @migration_class_name = name.underscore.classify
    end
  end
end
