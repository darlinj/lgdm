require 'rspec/core/rake_task'
Rake.application.instance_variable_get('@tasks').delete('default')

task :default do
  ENV['RAILS_ENV'] = 'test'
  Rake::Task[:clean].invoke
  Rake::Task['db:migrate'].invoke
  Rake::Task['code:trailing_spaces'].invoke
  #Rake::Task['code:run_roodi'].invoke
  Rake::Task['spec'].invoke
  Rake::Task['cucumber:all'].invoke
  Rake::Task['coverage:check_coverage'].invoke
  Rake::Task[:ok].invoke
end

RSpec::Core::RakeTask.new(:spec)

task :ok do
  red    = "\e[31m"
  yellow = "\e[33m"
  green  = "\e[32m"
  blue   = "\e[34m"
  purple = "\e[35m"
  bold   = "\e[1m"
  normal = "\e[0m"
  puts "", "#{bold}#{red}*#{yellow}*#{green}*#{blue}*#{purple}* #{green} ALL TESTS PASSED #{purple}*#{blue}*#{green}*#{yellow}*#{red}*#{normal}"
end
