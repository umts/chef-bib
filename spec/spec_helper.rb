require 'chefspec'
require_relative 'support/matchers'

Dir['cookbooks/**/libraries/*.rb'].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  # Specify the path for Chef Solo to find cookbooks (default: [inferred from
  # the location of the calling spec file])
  config.cookbook_path = ['cookbooks', 'vendor-cookbooks']

  # Specify the path for Chef Solo to find roles (default: [ascending search])
  config.role_path = 'roles'
end
