require 'spec_helper'

#
# Ensures swift-proxy is running, configured and responds
#

context "swift-proxy on #{property[:host]}" do
  describe package('swift-proxy') do
    it { should be_installed }
  end

  describe service('swift-proxy') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8080) do
    it { should be_listening.with('tcp') }
  end

  describe host("#{property[:host]}") do
    it { should be_reachable.with( :port => 8080 ) }
  end

  # swift-proxy listens on all interfaces
  hosts = ['localhost', property[:host], property[:ip]]
  hosts.each do |host|
    describe command("curl -s -o /dev/null -w '%{http_code}' http://#{host}:8080/info") do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /^200$/ }
    end

    describe command("curl http://#{host}:8080/healthcheck") do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /^OK$/ }
    end
  end
end
