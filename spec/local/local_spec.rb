spec_folder = File.expand_path('../../', __FILE__)
Dir["#{spec_folder}/tests/local/**/*.rb"].each {|f| require_relative f}
