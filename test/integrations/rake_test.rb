require 'test_helper'

describe 'Rake tasks' do
  before(:each) do
    @test_directory = File.expand_path('../../fixtures/test_project', __FILE__)
    ENV['ENRAR_ENV'] = 'development'
    @old_directory = Dir.pwd
    Dir.chdir @test_directory
    system 'bundle >/dev/null 2>&1'
    Enrar.clear_config!
    Enrar.root = @test_directory
    Enrar.initialize!
  end

  after(:each) do
    Dir.chdir @old_directory
    FileUtils.rm_r @test_directory + '/db'
  end

  describe 'enrar:migrations:generate' do
    it 'generates a migration' do
      i_call_rake_task 'enrar:migrations:generate', 'create_test_table'
      Dir[@test_directory + '/db/migrate/*_create_test_table.rb'].wont_be_empty
    end
  end

  describe 'enrar:db:create' do
    it 'creates the database file' do
      i_call_rake_task 'enrar:db:create'
      File.exist?(@test_directory + '/db/development.sqlite3').must_equal true
    end
  end
end
