serverspec-stuff
================

Just some Serverspec stuff I've been playing around with.
Not maintained, just for reference.
Inspired by https://github.com/redhat-cip/openstack-serverspec

What it looks like
==================

    bundle exec rake spec
    /Users/dmsimard/.rvm/rubies/ruby-1.9.3-p551/bin/ruby -I/Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-core-3.2.0/lib:/Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-support-3.2.1/lib /Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-core-3.2.0/exe/rspec --pattern spec/\{base\}/\*_spec.rb

    lb01.object.example.org DNS resolution
      Packages
        Package "dnsmasq"
          should be installed
        Service "dnsmasq"
          should be enabled
          should be running
        Package "dnsutils"
          should be installed
      Configuration
        File "/etc/resolv.conf"
          content
            should match /^nameserver 127\.0\.0\.1$/
      Tests
        Command "timeout 2 dig @127.0.0.1 google.com"
          exit_status
            should eq 0
        Host "lb01.object.example.org"
          should be resolvable
          should be resolvable
          should be resolvable

    lb01.object.example.org IPMI connectivity
      Packages
        File "/usr/local/bin/ipmicfg-linux.x86_64"
          should be file
          should be mode 755
          should be owned by "root"
          should be grouped into "root"
        Package "openipmi"
          should be installed
        Service "openipmi"
          should be enabled
        Kernel module "ipmi_devintf"
          should be loaded
      Configuration
        Command "ipmicfg-linux.x86_64 -m"
          exit_status
            should eq 0
          stdout
            should match /IP=10.0.1.10\nMAC=(.*)/
        Command "ipmicfg-linux.x86_64 -g"
          exit_status
            should eq 0
          stdout
            should match /Gateway=10.0.1.1/
        Command "ipmicfg-linux.x86_64 -dhcp"
          exit_status
            should eq 0
          stdout
            should match /DHCP is currently disabled./
        ipmi version
          should be >= 3.31
      Tests
        Command "ipmicfg-linux.x86_64 -selftest"
          exit_status
            should eq 0
          stdout
            should match /Selftest: Passed./

    Host "lb01.object.example.org"
      should be reachable

    lb01.object.example.org ssh connectivity
      Packages
        Package "openssh-server"
          should be installed
        Service "ssh"
          should be enabled
          should be running
      Configuration
        File "/etc/ssh/sshd_config"
          content
            should match /^Port 22$/
          content
            should match /^PermitRootLogin without-password$/
      Tests
        Port "22"
          should be listening
        Host "lb01.object.example.org"
          should be reachable

    Finished in 5.68 seconds (files took 0.38555 seconds to load)
    33 examples, 0 failures

    /Users/dmsimard/.rvm/rubies/ruby-1.9.3-p551/bin/ruby -I/Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-core-3.2.0/lib:/Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-support-3.2.1/lib /Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-core-3.2.0/exe/rspec --pattern spec/\{base\}/\*_spec.rb

    lb02.object.example.org DNS resolution
      Packages
        Package "dnsmasq"
          should be installed
        Service "dnsmasq"
          should be enabled
          should be running
        Package "dnsutils"
          should be installed
      Configuration
        File "/etc/resolv.conf"
          content
            should match /^nameserver 127\.0\.0\.1$/
      Tests
        Command "timeout 2 dig @127.0.0.1 google.com"
          exit_status
            should eq 0
        Host "lb02.object.example.org"
          should be resolvable
          should be resolvable
          should be resolvable

    lb02.object.example.org IPMI connectivity
      Packages
        File "/usr/local/bin/ipmicfg-linux.x86_64"
          should be file
          should be mode 755
          should be owned by "root"
          should be grouped into "root"
        Package "openipmi"
          should be installed
        Service "openipmi"
          should be enabled
        Kernel module "ipmi_devintf"
          should be loaded
      Configuration
        Command "ipmicfg-linux.x86_64 -m"
          exit_status
            should eq 0
          stdout
            should match /IP=10.0.1.11\nMAC=(.*)/
        Command "ipmicfg-linux.x86_64 -g"
          exit_status
            should eq 0
          stdout
            should match /Gateway=10.0.1.1/
        Command "ipmicfg-linux.x86_64 -dhcp"
          exit_status
            should eq 0
          stdout
            should match /DHCP is currently disabled./
        ipmi version
          should be >= 3.31
      Tests
        Command "ipmicfg-linux.x86_64 -selftest"
          exit_status
            should eq 0
          stdout
            should match /Selftest: Passed./

    Host "lb02.object.example.org"
      should be reachable

    lb02.object.example.org ssh connectivity
      Packages
        Package "openssh-server"
          should be installed
        Service "ssh"
          should be enabled
          should be running
      Configuration
        File "/etc/ssh/sshd_config"
          content
            should match /^Port 22$/
          content
            should match /^PermitRootLogin without-password$/
      Tests
        Port "22"
          should be listening
        Host "lb02.object.example.org"
          should be reachable

    Finished in 5.55 seconds (files took 0.34125 seconds to load)
    33 examples, 0 failures

    /Users/dmsimard/.rvm/rubies/ruby-1.9.3-p551/bin/ruby -I/Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-core-3.2.0/lib:/Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-support-3.2.1/lib /Users/dmsimard/.rvm/gems/ruby-1.9.3-p551/gems/rspec-core-3.2.0/exe/rspec --pattern spec/\{local\}/\*_spec.rb

    lb01.object.example.org should be resolvable
      Host "lb01.object.example.org"
        should be resolvable

    lb02.object.example.org should be resolvable
      Host "lb02.object.example.org"
        should be resolvable

    IPMI connectivity should work on lb01.object.example.org
      Host "10.0.1.10"
        ping
          should be reachable
        port 80
          should be reachable
        port 443
          should be reachable

    IPMI connectivity should work on lb02.object.example.org
      Host "10.0.1.11"
        ping
          should be reachable
        port 80
          should be reachable
        port 443
          should be reachable

    lb01.object.example.org should be reachable
      Host "lb01.object.example.org"
        should be reachable

    lb02.object.example.org should be reachable
      Host "lb02.object.example.org"
        should be reachable

    lb01.object.example.org should be reachable
      Host "lb01.object.example.org"
        should be reachable

    lb02.object.example.org should be reachable
      Host "lb02.object.example.org"
        should be reachable

    Finished in 6.3 seconds (files took 0.32872 seconds to load)
    12 examples, 0 failures
