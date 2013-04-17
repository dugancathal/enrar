class MiniTest::Unit::TestCase
  def i_call_rake_task(task_name, *args)
    rake= nil
    Dir.chdir(Enrar.gem_root) do
      # Get an instance of rake
      rake = Rake::Application.new
      Rake.application = rake
    end

    Rake.application.rake_require rake_task_path(task_name),
      [Enrar.gem_root.to_s],
      loaded_files_excluding_current_rake_file(task_name)

    task = rake[task_name]
    assert task, "No rake task defined: #{task_name}"
    task.invoke *args
  end

  def loaded_files_excluding_current_rake_file(file)
    $".reject {|file| file == Enrar.gem_root.join("#{rake_task_path(file)}.rake").to_s }
  end

  def rake_task_path(name)
    "tasks/#{name.split(":").first}"
  end
end
