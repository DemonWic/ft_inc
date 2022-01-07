export INSTALL_K3S_EXEC="--write-kubeconfig /home/vagrant/.kube/config --write-kubeconfig-mode 666 --node-ip 192.168.42.110"
su vagrant -c "curl -sfL https://get.k3s.io | sh -s -"
systemctl stop firewalld
systemctl disable firewalld
sleep 35