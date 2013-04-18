require 'test_helper'

describe Enrar::DB do
  describe 'creating the databse' do
    before(:each) do
      setup_test_project!
    end

    after(:each) do
      teardown_test_project!
    end

    it 'creates a migration file' do
      Enrar::DB.new.create!
      File.exist?(@test_directory + '/db/development.sqlite3').must_equal true
    end
  end
end
