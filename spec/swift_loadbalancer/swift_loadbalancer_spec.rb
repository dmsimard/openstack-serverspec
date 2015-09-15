spec_folder = File.expand_path('../../', __FILE__)
Dir["#{spec_folder}/tests/swift_loadbalancer/*.rb"].each {|f| require_relative f}
