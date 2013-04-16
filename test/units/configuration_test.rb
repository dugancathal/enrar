require 'test_helper'

describe 'configurations' do
  describe Enrar, '.root' do
    it "points to the user's project's root" do
      Enrar.root.to_s.must_equal File.expand_path('../../../', __FILE__)
    end
  end

  describe Enrar, '.gem_root' do
    it "points to Enrar's root" do
      Enrar.root.to_s.must_equal File.expand_path('../../../', __FILE__)
    end

    it "stays the same even if I change directory" do
      old_root = Enrar.root
      Dir.chdir('/') do
        Enrar.root.must_equal old_root
      end
    end
  end


  describe Enrar, '.root=' do
    def new_root 
      File.expand_path('../../fixtures/test_project', __FILE__)
    end

    it "sets the location of the user's project's root" do
      Enrar.root = new_root
      Enrar.root.to_s.must_equal new_root
    end

    it "creates it as a Pathname" do
      Enrar.root = new_root
      Enrar.root.must_be_kind_of Pathname
    end
  end

  describe Enrar, '.db_config' do
    it 'defaults to Enrar.root.join(config/database.yml)' do
      Enrar.db_config.must_equal Enrar.root.join('config', 'database.yml')
    end

    it 'is a Pathname object' do
      Enrar.db_config.must_be_kind_of Pathname
    end

    it 'is a YAML file' do
      Enrar.db_config.basename.to_s.must_match /ya?ml/i
    end
  end
end
