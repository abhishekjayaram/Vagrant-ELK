# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.define "elkm" do |elkm|
    elkm.vm.box = "ubuntu/xenial64"
    # elkm.vm.network "private_network", ip: "192.168.2.10", virtualbox__intnet: "mynetwork"
    elkm.vm.network "forwarded_port", guest: 80, host: 9001
    # elkm.vm.network "public_network"
    elkm.vm.provision "shell", path: "install.sh"
    config.vm.provider "virtualbox" do |vb1|
      vb1.memory = 4096
      vb1.cpus = 2
    end
  end
end
