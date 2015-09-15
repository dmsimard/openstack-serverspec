require 'spec_helper'

#
# Ensures server has proper network connectivity and configuration
#

context "#{property[:host]} network connectivity" do
  describe host("#{property[:host]}") do
    it { should be_reachable }
  end

  describe file('/etc/network/interfaces') do
    its(:content) { should match /address\s+#{property[:ip]}/ }
  end
end
