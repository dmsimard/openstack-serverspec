require 'spec_helper'

#
# Ensures dns resolution is configured and works properly
#

context "#{property[:host]} DNS resolution" do
  context 'Packages' do
    describe package('dnsmasq') do
      it { should be_installed }
    end

    describe service('dnsmasq') do
      it { should be_enabled }
      it { should be_running }
    end

    describe package('dnsutils') do
      it { should be_installed }
    end
  end

  context 'Configuration' do
    describe file('/etc/resolv.conf') do
      its(:content) { should match /^nameserver 127\.0\.0\.1$/ }
    end
  end

  context 'Tests' do
    describe command('timeout 2 dig @127.0.0.1 google.com') do
      its(:exit_status) { should eq 0 }
    end

    describe host(property[:host]) do
      it { should be_resolvable }
      it { should be_resolvable.by('hosts') }
      it { should be_resolvable.by('dns') }
    end
  end
end
