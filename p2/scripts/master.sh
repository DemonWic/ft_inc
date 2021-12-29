echo "192.168.42.110 ahintzS" >> /etc/hosts
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
yum -y install net-tools
yum -y install firewalld
systemctl start firewalld
systemctl disable firewalld --now
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
export K3S_NODE_NAME=ahintzS
export INSTALL_K3S_EXEC="--write-kubeconfig /home/vagrant/.kube/config --write-kubeconfig-mode 666 --node-ip 192.168.42.110"
su vagrant -c "curl -sfL https://get.k3s.io | sh -s -"
sleep 30