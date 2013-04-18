require 'test_helper'

describe Enrar do
  before(:each) do
    setup_test_project!
  end

  after(:each) do
    teardown_test_project!
  end

  describe '.setup!' do
    it 'works like initialize!, but it creates and migrates the db first' do
      Enrar.setup!
      ActiveRecord::Base.connected?.must_equal true
    end
  end
end
