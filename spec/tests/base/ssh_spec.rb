require 'spec_helper'

#
# Ensures SSH is configured and works properly
#

context "#{property[:host]} ssh connectivity" do
  context 'Packages' do
    describe package('openssh-server') do
      it { should be_installed }
    end

    describe service('ssh') do
      it { should be_enabled }
      it { should be_running }
    end
  end

  context 'Configuration' do
    describe file('/etc/ssh/sshd_config') do
      its(:content) { should match /^Port 22$/ }
      its(:content) { should match /^PermitRootLogin without-password$/ }
    end
  end

  context 'Tests' do
    describe port(22) do
      it { should be_listening.with('tcp') }
    end

    describe host("#{property[:host]}") do
      it { should be_reachable.with( :port => 22 ) }
    end
  end
end
