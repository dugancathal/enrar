require 'test_helper'

describe 'configurations' do
  describe Enrar, 'db_config' do
    it 'defaults to Enrar.root.join(config/database.yml)' do
      Enrar.db_config.must_equal Enrar.root.join('config', 'database.yml')
    end

    it 'is a Pathname object' do
      Enrar.db_config.must_be_kind_of Pathname
    end

    it 'is a YAML file' do
      Enrar.db_config.basename.to_s.must_match /ya?ml/i
    end
  end
end
