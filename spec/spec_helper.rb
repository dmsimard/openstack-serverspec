require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'yaml'

set :backend, :ssh

config = YAML.load_file("config.yaml")

defaults = {
  "username" => "root",
  "port"     => "22"
}

host = ENV["TARGET_HOST"]
user = config[host][:username] ||= defaults["username"]
set_property config[host]

set :host, host
set :ssh_options, :user => user
set :disable_sudo, true
