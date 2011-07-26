require 'roodi'
require "rake/clean"

CLEAN.include %w(log/** tmp/** coverage)

namespace :code do

  desc "Cleans & checks trailing spaces, rspec, rcov, roodi, cucumber"
  task :run_checks => [:clean] do
    ENV['RAILS_ENV'] = 'test'
    Rake::Task['db:migrate'].invoke
    Rake::Task['code:trailing_spaces'].invoke
    Rake::Task['spec:rcov'].invoke
    Rake::Task['spec:rcov'].invoke
    #Rake::Task['code:run_roodi'].invoke
    Rake::Task['spec'].invoke
    Rake::Task['cucumber:all'].invoke
  end


  desc 'Runs roodi design/convention checker'
  task :run_roodi do
    roodi   = Roodi::Core::Runner.new
    pattern = File.dirname(__FILE__) + '/../../app/**/*.rb'
    logfile = File.dirname(__FILE__) + '/../../log/roodi.txt'

    Dir.glob(pattern) { |file| roodi.check_file(file) }
    File.open logfile, 'w' do |f|
      roodi.errors.each { |error| f.puts error}
      f.puts "\nRoodi found #{roodi.errors.size} errors.\n"
    end
    puts File.read logfile
    raise 'Roodi found errors' unless roodi.errors.empty?
  end

  desc "Checks for trailing spaces"
  task :trailing_spaces do
    grep "app/*", "features/*", "lib/*", "spec/*"
  end

  def grep(*file_patterns)
    files_found = ""
    file_patterns.each do |file_pattern|
      files_found << `grep -r -I -E '^.*[[:space:]]+$' #{file_pattern}`
    end
    abort("trailing spaces found:\n#{files_found}") unless files_found.empty?
  end
end

