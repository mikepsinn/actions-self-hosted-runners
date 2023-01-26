# -*- mode: ruby -*-
# vi: set ft=ruby :

Dotenv.load

VB_DISK_SIZE = ENV["VB_DISK_SIZE"] || '30GB'
VB_CPUS = ENV["VB_CPUS"] || '3'
VB_MEMORY = ENV["VB_MEMORY"] || '3000'
GHA_RUNNER_VERSION = ENV["GHA_RUNNER_VERSION"] || '2.299.1'
HOSTNAME = ENV["HOSTNAME"] || ENV['COMPUTERNAME'] || 'vagrant'

Vagrant.configure("2") do |config|
  config.vm.network "forwarded_port", guest: 7777, host: 7777, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 22, host: 2222, protocol: "tcp"
  config.vm.network "forwarded_port", guest: 80, host: 80, protocol: "tcp"
  config.vm.box = "generic/ubuntu2004"
  config.vm.disk :disk, size: "#{VB_DISK_SIZE}", primary: true
  config.vm.box_check_update = true
  #config.vm.host_name = "vagrant-actions-runner"
  config.vm.hostname = "#{HOSTNAME}"+"-actions-runner"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of cpus and memory on the VM:
    vb.cpus = "#{VB_CPUS}".to_i
    vb.memory = "#{VB_MEMORY}".to_i

    # Fix https://www.virtualbox.org/ticket/15705
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
    vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]

    config.vm.synced_folder ".", "/vagrant", disabled: false

  end

    config.vm.provision :root_user, type: "shell", path: "provision_root.sh"
    config.vm.provision :vagrant_user, type: "shell", privileged: false, path: "provision_nonroot.sh"
    #config.vm.provision :vagrant_user_runner_install, type: "shell", privileged: false, path: "actions-runner-install.sh"

    #config.vm.provision type: "inline", run: 'always', inline: 'sudo chown -R vagrant:vagrant /home/vagrant/actions-runner'
    #config.vm.provision "shell", path: "actions-runners.sh"
    #config.vm.provision :vagrant_user_runner_install type: "shell", privileged: false, path: "actions-runners.sh", run: 'always'
end
