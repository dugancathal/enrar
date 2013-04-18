require 'test_helper'

class MiniTest::Unit::TestCase
  def setup_test_project!
    @test_directory = File.expand_path('../../fixtures/test_project', __FILE__)
    @old_directory = Dir.pwd
    ENV['ENRAR_ENV'] = 'development'

    Enrar.clear_config!
    Enrar.root = @test_directory
    Dir.chdir @test_directory
    Enrar.initialize!

    @migration_versions = []
    %w(create_tests create_posts create_users).each do |migration_name|
      sample = File.read(File.expand_path("../../fixtures/#{migration_name}.rb", __FILE__))
      migration = Enrar::Migration.new(migration_name).generate!
      File.write(migration.path, sample)
      @migration_versions << migration.version
    end
  end

  def teardown_test_project!
    Enrar.clear_config!
    FileUtils.rm_r @test_directory + '/db'
    Dir.chdir @old_directory
  end
end
