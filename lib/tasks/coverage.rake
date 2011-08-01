begin
  require "simplecov"

  namespace :coverage do
    task :check_specs do
      SimpleCov.coverage_dir 'log/coverage/rspec'
      coverage = SimpleCov.result.covered_percent
      fail "Spec coverage was only #{coverage}%" if coverage < 100.0
    end

    task :check_cucumber do
      SimpleCov.coverage_dir 'log/coverage/cucumber'
      coverage = SimpleCov.result.covered_percent
      fail "Feature coverage was only #{coverage}%" if coverage < 100.0
    end
  end
rescue LoadError
  namespace :coverage do
    task :check_specs do
      abort "SimpleCov not available"
    end
    task :check_cucumber do
      abort "SimpleCov not available"
    end
  end
end
