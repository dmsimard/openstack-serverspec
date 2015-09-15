require 'spec_helper'

#
# Ensures server is reachable by ping from localhost
#

config = YAML.load_file("config.yaml")
config.keys.each do |key|
  # Skip localhost iteration, don't want to actually test it.
  # Only run tests from it.
  if config[key][:host] == 'localhost'
    next
  end

  describe "#{config[key][:host]} should be reachable" do
    describe host(config[key][:host]) do
      it { should be_reachable }
    end
  end
end
