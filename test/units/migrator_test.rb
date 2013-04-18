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

      @migration_versions = []
      %w(create_tests create_posts create_users).each do |migration_name|
        sample = File.read(File.expand_path("../../fixtures/#{migration_name}.rb", __FILE__))
        migration = Enrar::Migration.new(migration_name).generate!
        File.write(migration.path, sample)
        @migration_versions << migration.version
      end
    end

    after(:each) do
      FileUtils.rm_r @test_directory + '/db'
      Dir.chdir @old_directory
    end

    it 'runs all migrations in the migration_dir' do
      Enrar::Migrator.new(nil, verbose: false).migrate!
      ActiveRecord::Base.connection.table_exists?('tests').must_equal true
    end

    it 'accepts a migration version' do
      Enrar::Migrator.new(@migration_versions.first.to_i, verbose: false).migrate!
      ActiveRecord::Base.connection.table_exists?('tests').must_equal true
      ActiveRecord::Base.connection.table_exists?('posts').must_equal false, 'Posts WAS created'
      ActiveRecord::Base.connection.table_exists?('users').must_equal false, 'Users WAS created'
    end
  end
end
