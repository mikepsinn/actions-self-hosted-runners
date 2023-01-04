# -*- mode: ruby -*-
# vi: set ft=ruby :

Dotenv.load

VB_DISK_SIZE = ENV["VB_DISK_SIZE"] || '30GB'
VB_CPUS = ENV["VB_CPUS"] || '4'
VB_MEMORY = ENV["VB_MEMORY"] || '4000'
GHA_RUNNER_VERSION = ENV["GHA_RUNNER_VERSION"] || '2.299.1'

Vagrant.configure("2") do |config|
  # config.vm.network "forwarded_port", guest: 7777, host: 7777, protocol: "tcp"
  config.vm.box = "generic/ubuntu2004"
  config.vm.disk :disk, size: "#{VB_DISK_SIZE}", primary: true
  config.vm.box_check_update = true
  config.vm.host_name = "infinity-actions-runner"

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of cpus and memory on the VM:
    vb.cpus = "#{VB_CPUS}".to_i
    vb.memory = "#{VB_MEMORY}".to_i

    # Fix https://www.virtualbox.org/ticket/15705
    vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
  end

    config.vm.provision :root_user, type: "shell", path: "provision_root.sh"
    config.vm.provision :vagrant_user, type: "shell", privileged: false, path: "provision_nonroot.sh"
    config.vm.provision :vagrant_user_runner_install, type: "shell", privileged: false, path: "actions-runner-install.sh"

    config.vm.provision :shell, path: "actions-runners.sh", run: 'always'
end
