spec_folder = File.expand_path('../../', __FILE__)
Dir["#{spec_folder}/tests/base/*.rb"].each {|f| require_relative f}
