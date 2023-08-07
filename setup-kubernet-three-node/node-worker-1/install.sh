#Step 1: Install Kubernetes
sudo apt install apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" >> ~/kubernetes.list

sudo mv ~/kubernetes.list /etc/apt/sources.list.d

sudo apt update

sudo apt install kubelet

sudo apt install kubeadm

sudo apt install kubectl

sudo apt-get install -y kubernetes-cni

sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni


#Step 2: Disabling Swap Memory

sudo swapoff -a

sudo nano /etc/fstab


#Step 3: Setting Unique Hostnames

sudo hostnamectl set-hostname node-worker-1

#Step 4: Letting Iptables See Bridged Traffic

lsmod | grep br_netfilter

sudo modprobe br_netfilter

sudo sysctl net.bridge.bridge-nf-call-iptables=1


#Step 5: Changing Docker Cgroup Driver

sudo mkdir /etc/docker

cat <<EOF | sudo tee /etc/docker/daemon.json
{ "exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"log-opts":
{ "max-size": "100m" },
"storage-driver": "overlay2"
}
EOF

# Install Docker
sudo apt install -y docker.io

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

#Step 7: Create Cluster For (MasterNode)
# sudo kubeadm init --pod-network-cidr=10.0.0.0/16

# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config

# sudo ufw allow 6443
# sudo ufw allow 6443/tcp

#Step 7: Join (WorkerNode) to Cluster

# After we run Create Cluster this command show in cmd, copy to for worker node

# sudo kubeadm join "":6443 --token "" --discovery-token-ca-cert-hash ""

#Step 8: Setup pod network

# Recommend
# kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml


# Không làm được
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# Or
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-old-manifests/kube-flannel-legacy.yml

# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-old-manifests/kube-flannel-rbac.yml
