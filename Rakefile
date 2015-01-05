require 'rake/clean'
require 'yaml'
require 'json'

CLEAN.include('node.json')

namespace :bib do
  desc "Build the json configuration file"
  file 'node.json', :role do |t, args|
    out = {bib: @config, run_list: [ "role[#{args[:role]}]" ]}

    File.open(t.name, 'w') do |file|
      file.write( out.to_json )
    end
  end

  desc "Install the Bus Info Board"
  task :install, :role do |t, args|
    @config = YAML::load(File.open(File.join(File.dirname(__FILE__), 'config', 'bib.yml')))
    default_role = @config.delete('default_role')

    args.with_defaults(role: default_role)

    Rake::Task['node.json'].invoke(args[:role])

    system('chef-solo -j node.json -c config/solo.rb')
  end
end
