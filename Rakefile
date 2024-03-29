# frozen_string_literal: true

require 'rake/clean'
require 'yaml'
require 'json'

CLEAN.include('node.json')
config_file = File.join(File.dirname(__FILE__), 'config', 'bib.yml')

namespace :bib do
  desc 'Build the json configuration file'
  file 'node.json', [:role] => [config_file] do |t, args|
    config = YAML.safe_load(File.open(config_file))
    args.with_defaults(role: config.delete('default_role'))

    out = config.merge(run_list: ["role[#{args[:role]}]"])

    File.open(t.name, 'w') do |file|
      file.write(out.to_json)
    end
  end

  desc 'Install the Bus Info Board'
  task :install, [:role] => ['node.json'] do |_, args|
    command = 'chef-solo -N chef-bib -j node.json -c config/solo.rb'
    command += ' -N chef-bib-tk --chef-license accept' if args[:role] == 'test'
    system(command, exception: true)
  end
end

def optional_gem_task(req)
  require req
  yield
rescue LoadError
  gemname = req.split('/').first.capitalize
  puts ">>>>> #{gemname} gem not loaded; ommitting task" unless ENV['CI']
end

optional_gem_task('kitchen/rake_tasks') do
  Kitchen::RakeTasks.new
end

style_tasks = []
namespace :style do
  optional_gem_task('rubocop/rake_task') do
    RuboCop::RakeTask.new(:ruby)
    style_tasks << 'style:ruby'
  end
  optional_gem_task('cookstyle') do
    RuboCop::RakeTask.new(:chef) do |task|
      task.options << '--display-cop-names'
    end
    style_tasks << 'style:chef'
  end
end

if style_tasks.any?
  desc 'Run all style checks'
  task style: style_tasks
end
