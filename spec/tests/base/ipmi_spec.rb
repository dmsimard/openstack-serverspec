require 'spec_helper'

#
# Ensures IPMI tools are installed and that IPMI is configured properly
#

context "#{property[:host]} IPMI connectivity" do
  context 'Packages' do
    describe file('/usr/local/bin/ipmicfg-linux.x86_64') do
      it { should be_file }
      it { should be_mode 755 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end

    describe package('openipmi') do
      it { should be_installed }
    end

    describe service('openipmi') do
      it { should be_enabled }
    end

    # Expect ipmi_devintf to be loaded properly by openipmi
    describe kernel_module('ipmi_devintf') do
      it { should be_loaded }
    end
  end

  context 'Configuration' do
    describe command('ipmicfg-linux.x86_64 -m') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /IP=#{property[:ipmi]}\nMAC=(.*)/ }
    end

    describe command('ipmicfg-linux.x86_64 -g') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /Gateway=#{property[:ipmi_gateway]}/ }
    end

    describe command('ipmicfg-linux.x86_64 -dhcp') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /DHCP is currently disabled./ }
    end

    describe "ipmi version" do
      it 'should be >= 3.31' do
        ipmi_version = command("ipmicfg-linux.x86_64 -ver |awk '{print $3}'").stdout.to_f
        expect(ipmi_version).to be >= 3.31
      end
    end
  end

  context 'Tests' do
    describe command('ipmicfg-linux.x86_64 -selftest') do
      its(:exit_status) { should eq 0 }
      its(:stdout) { should match /Selftest: Passed./ }
    end
  end
end
