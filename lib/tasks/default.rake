Rake.application.instance_variable_get('@tasks').delete('default')

task :default do
  Rake::Task['code:run_checks'].invoke
end
