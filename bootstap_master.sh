#!/usr/bin/env bash

yum update
systemctl disable firewalld && systemctl stop firewalld
setenforce 0 
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux

modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
update-alternatives --set iptables /usr/sbin/iptables-legacy
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Set SELinux in permissive mode (effectively disabling it)
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
yum install wget nano yum-utils device-mapper-persistent-data lvm2 docker-ce kubelet kubeadm kubectl kubernetes-cni --disableexcludes=kubernetes -y

systemctl enable --now docker 
systemctl start docker 
systemctl enable --now kubelet
systemctl start kubelet

sysctl net.bridge.bridge-nf-call-iptables=1
sysctl net.bridge.bridge-nf-call-ip6tables=1

swapoff -a

kubeadm init --apiserver-advertise-address=0.0.0.0