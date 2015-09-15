require 'spec_helper'

#
# Ensures IPMI is reachable from localhost
#

config = YAML.load_file("config.yaml")
config.keys.each do |key|
  # Skip localhost iteration, don't want to actually test it.
  # Only run tests from it.
  if config[key][:host] == 'localhost'
    next
  end

  if config[key][:ipmi]
    describe "IPMI connectivity should work on #{config[key][:host]}" do
      describe host(config[key][:ipmi]) do
        describe('ping') do
          it { should be_reachable }
        end

        ipmi_ports = ['80', '443']
        ipmi_ports.each do |port|
          describe("port #{port}") do
            it { should be_reachable.with( :port => port) }
          end
        end
      end
    end
  end
end
