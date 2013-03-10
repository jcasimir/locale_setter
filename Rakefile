require 'rake'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

def run_in_dummy_app(command)
  success = system("cd spec/dummy && #{command}")
  raise "#{command} failed" unless success
end

task "default" => "ci"

desc "Run all tests for CI"
task "ci" => "spec"

desc "Run all specs"
task "spec" => "spec:all"

namespace "spec" do
  task "all" => ["locale_setter", "requests"]

  def spec_task(name)
    desc "Run #{name} specs"
    RSpec::Core::RakeTask.new(name) do |t|
      t.pattern = "spec/#{name}/**/*_spec.rb"
    end
  end

  spec_task "locale_setter"

  desc "Run request specs"
  task "requests" => ["db:setup", "requests:all"]

  namespace "requests" do
    task "all" => ["development", "production", "test"]

    ["development", "production"].each do |environment|
      task environment do
        Rake::Task["spec:requests:run"].execute environment
      end
    end

    task "run" do |t, environment|
      puts "Running request specs in #{environment}"

      ENV["RAILS_ENV"] = environment
      success = system("rspec spec/requests")

      raise "Integration specs failed in #{environment}" unless success
    end

    task "test" do
      puts "Running rake in dummy app"
      ENV["RAILS_ENV"] = "test"
      run_in_dummy_app "rake"
    end
  end
end

namespace "db" do
  desc "Set up databases for integration testing"
  task "setup" do
    puts "Setting up databases"
    run_in_dummy_app "rm -f db/*.sqlite3"
    run_in_dummy_app "RAILS_ENV=development rake db:schema:load db:seed"
    run_in_dummy_app "RAILS_ENV=production rake db:schema:load db:seed"
    run_in_dummy_app "RAILS_ENV=test rake db:schema:load"
  end
end

