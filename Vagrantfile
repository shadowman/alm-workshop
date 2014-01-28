# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.hostname = "development"
  config.vm.provider :virtualbox do |vb|
     # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "1024"]
   end
 
  config.vm.provision :puppet, :module_path => "puppet/modules" do |puppet|
     puppet.manifests_path = "puppet/manifests"
     puppet.manifest_file  = "workshop.pp"
  end

  config.vm.define "dev" do |dev| 
    dev.vm.hostname = "dev"
    dev.vm.network :private_network, ip: "10.10.10.2"
  end

  config.vm.define "ci" do |ci| 
    ci.vm.hostname = "ci"
    ci.vm.network :private_network, ip: "10.10.10.3"
  end
end
