touch /home/vagrant/token
echo "192.168.42.110 ahintzS" >> /etc/hosts
echo "192.168.42.111 ahintzSW" >> /etc/hosts
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
yum -y install net-tools
yum -y install firewalld
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --permanent --add-port=6443/tcp
firewall-cmd --permanent --add-port=2379-2380/tcp
firewall-cmd --permanent --add-port=10250/tcp
firewall-cmd --permanent --add-port=10251/tcp
firewall-cmd --permanent --add-port=10252/tcp
firewall-cmd --permanent --add-port=10255/tcp
firewall-cmd --reload
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
export K3S_NODE_NAME=ahintzS
export INSTALL_K3S_EXEC="--write-kubeconfig ~/.kube/config --write-kubeconfig-mode 666 --bind-address 192.168.42.110 --advertise-address 192.168.42.110 --node-ip 192.168.42.110 --tls-san 192.168.42.110"
su vagrant -c "curl -sfL https://get.k3s.io | sh -s -"
cp /var/lib/rancher/k3s/server/node-token  /home/vagrant/token
chown vagrant /home/vagrant/token
cat /vagrant/keys/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys