namespace :secretfile do
  task :generate do
    File.write('.super-secret', 'CODES!')
  end
end
