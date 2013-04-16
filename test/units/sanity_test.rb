require 'test_helper'

describe 'Sanity' do
  it 'passes' do
    true.must_equal true
  end

  describe 'secretfile:generate', 'A test that rake testing works' do
    after(:all) do
      File.delete '.super-secret'
    end

    it 'generates the secret file' do
      i_call_rake_task 'secretfile:generate'
      File.exists?('.super-secret').must_equal true
    end
  end
end
