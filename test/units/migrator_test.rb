require 'test_helper'

describe Enrar::Migrator do
  describe 'migrating the database' do
    before(:each) do
      setup_test_project!
    end

    after(:each) do
      teardown_test_project!
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
