require 'test_helper'

describe Enrar::DB do
  describe 'creating the databse' do
    before(:each) do
      @test_directory = File.expand_path('../../fixtures/test_project', __FILE__)
      ENV['ENRAR_ENV'] = 'development'
      Enrar.clear_config!
      Enrar.root = @test_directory
      Enrar.initialize!
    end

    after(:each) do
      # FileUtils.rm_r @test_directory + '/db'
    end

    it 'creates a migration file' do
      Enrar::DB.new.create!
      File.exist?(@test_directory + '/db/development.sqlite3').must_equal true
    end
  end
end
