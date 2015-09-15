require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

config = YAML.load_file('config.yaml')

desc "Run serverspec to all hosts"
task :spec => 'serverspec:all'

namespace :serverspec do
  task :all => config.keys.map {|key| 'serverspec:' + key.split('.')[0] }
  config.keys.each do |key|
    desc "Run serverspec to #{key}"
    RSpec::Core::RakeTask.new(key.split('.')[0].to_sym) do |t|
      ENV['TARGET_HOST'] = key
      t.pattern = 'spec/{' + config[key][:roles].join(',') + '}/*_spec.rb'
    end
  end
end
