require 'test_helper'

describe Enrar::Migration do
  it 'accepts an underscored name' do
    Enrar::Migration.new('create_test_table').migration_class_name.must_equal 'CreateTestTable'
  end

  it 'accepts a camelized name' do
    Enrar::Migration.new('CreateTestTable').migration_class_name.must_equal 'CreateTestTable'
  end

  describe 'generating a migration' do
    before(:each) do
      @test_directory = File.expand_path('../../fixtures/test_project', __FILE__)
      ENV['ENRAR_ENV'] = 'development'
      Enrar.clear_config!
      Enrar.root = @test_directory
      Enrar.initialize!
    end

    after(:each) do
      FileUtils.rm_r @test_directory + '/db'
    end

    it 'creates a migration file' do
      migration = Enrar::Migration.new('create_test_table')
      migration.generate!
      File.exist?(migration.path).must_equal true
    end
  end
end
