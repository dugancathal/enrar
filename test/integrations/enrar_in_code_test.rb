require 'test_helper'

describe 'Enrar used in code' do
  before(:each) { setup_test_project! }
  after(:each) { teardown_test_project! }

  it 'should fully setup ActiveRecord via config' do
    `bundle exec bin/connection-test 2>&1`.must_match /true/i
  end
end
