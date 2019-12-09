# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Master
  config.vm.define "kubemaster", primary: true do |kubemaster|
    kubemaster.vm.box = "centos/7"
    kubemaster.vm.hostname = "kubemaster"
    kubemaster.vm.network "private_network", ip: "192.168.2.20"
    kubemaster.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end
    kubemaster.vm.provider :virtualbox do |vb|
      vb.name = "kubemaster"
    end
    kubemaster.vm.provision :shell, path: "bootstap_master.sh"
  end

  # Slave 1
  config.vm.define "kubeslave1" do |kubeslave1|
    kubeslave1.vm.box = "centos/7"
    kubeslave1.vm.hostname = "kubeslave1"
    kubeslave1.vm.provider :virtualbox do |vb1|
      vb1.name = "kubeslave1"
    end
    kubeslave1.vm.network "private_network", ip: "192.168.2.21"
    kubeslave1.vm.provider "virtualbox" do |v1|
      v1.memory = 1024
      v1.cpus = 1
    end
    kubeslave1.vm.provision :shell, path: "bootstrap.sh"
  end

  # Slave 2
  config.vm.define "kubeslave2" do |kubeslave2|
    kubeslave2.vm.box = "centos/7"
    kubeslave2.vm.hostname = "kubeslave2"
    kubeslave2.vm.provider :virtualbox do |vb2|
      vb2.name = "kubeslave2"
    end
    kubeslave2.vm.network "private_network", ip: "192.168.2.22"
    kubeslave2.vm.provider "virtualbox" do |v2|
      v2.memory = 1024
      v2.cpus = 1
    end
    kubeslave2.vm.provision :shell, path: "bootstrap.sh"
  end
end