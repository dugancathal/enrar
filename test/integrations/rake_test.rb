require 'test_helper'

describe 'Rake tasks' do
  before(:each) do
    setup_test_project!
  end

  after(:each) do
    teardown_test_project!
  end

  describe 'enrar:migrations:generate' do
    it 'generates a migration' do
      i_call_rake_task 'enrar:migrations:generate', 'create_test_table'
      Dir[@test_directory + '/db/migrate/*_create_test_table.rb'].wont_be_empty
    end
  end
end
