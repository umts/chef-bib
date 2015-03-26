require 'rake/clean'
require 'yaml'
require 'json'

CLEAN.include('node.json')

namespace :bib do
  desc 'Build the json configuration file'
  file 'node.json', :role do |t, args|
    out = { bib: @config, run_list: ["role[#{args[:role]}]"] }

    File.open(t.name, 'w') do |file|
      file.write(out.to_json)
    end
  end

  desc 'Install the Bus Info Board'
  task :install, :role do |_, args|
    @config = YAML.load(File.open(File.join(File.dirname(__FILE__), 'config', 'bib.yml')))
    default_role = @config.delete('default_role')

    args.with_defaults(role: default_role)

    Rake::Task['node.json'].invoke(args[:role])

    system('chef-solo -j node.json -c config/solo.rb')
  end
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end

style_tasks = []
namespace :style do
  begin
    require 'rubocop/rake_task'
    RuboCop::RakeTask.new(:ruby)
    style_tasks << 'style:ruby'
  rescue LoadError
    puts '>>>>> Rubocop gem, not loaded, omitting tasks' unless ENV['CI']
  end

  begin
    require 'foodcritic'
    FoodCritic::Rake::LintTask.new(:chef)
    style_tasks << 'style:chef'
  rescue LoadError
    puts '>>>>> Foodcritic gem, not loaded, omitting tasks' unless ENV['CI']
  end
end

if style_tasks.any?
  desc 'Run all style checks'
  task style: style_tasks
end
