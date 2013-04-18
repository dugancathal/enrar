require 'test_helper'

describe Enrar::Migrator do
  describe 'migrating the database' do
    before(:each) do
      @test_directory = File.expand_path('../../fixtures/test_project', __FILE__)
      @old_directory = Dir.pwd
      ENV['ENRAR_ENV'] = 'development'

      Enrar.clear_config!
      Enrar.root = @test_directory
      Dir.chdir @test_directory
      Enrar.initialize!

      sample_migration = File.read(File.expand_path('../../fixtures/migration.sample.rb', __FILE__))
      migration = Enrar::Migration.new('create_tests').generate!
      File.write(migration.path, sample_migration)
    end

    after(:each) do
      FileUtils.rm_r @test_directory + '/db'
      Dir.chdir @old_directory
    end

    it 'runs the migrations in the migration_dir' do
      Enrar::Migrator.new(nil, verbose: false).migrate
      ActiveRecord::Base.connection.table_exists?('tests').must_equal true
    end
  end
end
