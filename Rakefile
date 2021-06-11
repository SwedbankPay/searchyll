require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :codecov do
  desc "Uploads the latest SimpleCov result set to codecov.io"
  task :upload do
    require "simplecov"
    require "codecov"

    formatter = SimpleCov::Formatter::Codecov.new
    formatter.format(SimpleCov::ResultMerger.merged_result)
  end
end
