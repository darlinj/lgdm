begin
  require "simplecov"

  namespace :coverage do
    task :check_coverage do
      SimpleCov.coverage_dir '/coverage'
      coverage = SimpleCov.result.covered_percent
      fail "Coverage was only #{coverage}%" if coverage < 100.0
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
