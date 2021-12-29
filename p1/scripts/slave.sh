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
cp /vagrant/keys/* /home/vagrant/.ssh/
chmod 600 /home/vagrant/.ssh/id_rsa
chown -R vagrant /home/vagrant/.ssh/
su vagrant -c "scp -o StrictHostKeyChecking=no 192.168.42.110:/home/vagrant/token /home/vagrant/token"
export K3S_NODE_NAME=ahintzSW
export K3S_URL="https://192.168.42.110:6443"
export INSTALL_K3S_EXEC="--node-ip 192.168.42.111"
export K3S_TOKEN=$(cat /home/vagrant/token)
curl -sfL https://get.k3s.io | sh -s -