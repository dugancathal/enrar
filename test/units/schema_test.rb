require 'test_helper'

describe Enrar::Schema do
  before(:each) do
    setup_test_project!
    Enrar::Migrator.new(nil, verbose: false).migrate!
  end

  after(:each) { teardown_test_project! }

  it 'knows the version number' do
    Enrar::Schema.new.version.must_equal @migration_versions.last
  end
end
