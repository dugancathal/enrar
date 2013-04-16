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

  describe Enrar do
    before(:each) { Enrar.clear_config! }

    describe '.clear_config' do
      it 'clears out all the configuration settings' do
        default_root = Enrar.root
        Enrar.root = '/lib/some/where'
        Enrar.clear_config!
        Enrar.root.must_equal default_root
      end
    end

    describe '.env' do
      it 'defaults to "development"' do
        ENV['ENRAR_ENV'] = nil
        Enrar.env.must_equal 'development'
      end

      it 'is set-able via CLI option ENRAR_ENV' do
        ENV['ENRAR_ENV'] = 'production'
        Enrar.env.must_equal 'production'
      end
    end

    describe '.loaded_rake_tasks' do
      it 'returns an empty array initially' do
        Enrar.loaded_rake_tasks.must_be_empty
      end
    end

    describe '.load_rake_tasks!' do
      it 'loads all the rake tasks in Enrar.gem_root.join(tasks)' do
        Enrar.load_rake_tasks!
        Enrar.loaded_rake_tasks.wont_be_empty
      end
    end
  end

  describe 'a test project' do
    before(:each) do
      ENV['ENRAR_ENV'] = 'development'
      Enrar.clear_config!
      Enrar.root = File.expand_path('../../fixtures/test_project', __FILE__)
      Enrar.initialize!
    end

    describe Enrar, '.initialize!' do
      it 'loads the environment and sets up ActiveRecord' do
      end
    end

    describe ActiveRecord::Base, '.configurations' do
      it 'is set with Enrar.db_config' do
        parsed_yaml = YAML::load_file(Enrar.db_config)
        ActiveRecord::Base.configurations.must_equal parsed_yaml
      end
    end
  end
end
