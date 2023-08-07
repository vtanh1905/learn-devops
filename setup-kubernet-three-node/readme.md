Ref: 
- https://www.cloudsigma.com/how-to-install-and-use-kubernetes-on-ubuntu-20-04/#prereq
- https://www.letscloud.io/community/how-to-install-kubernetesk8s-and-docker-on-ubuntu-2004
- https://viblo.asia/p/k8s-xay-dung-kubernetes-cluster-bang-cong-cu-kubeadm-tren-virtual-box-38X4ENOAJN2

Note:
- Remember change hostname

- Handon Setup Cluster Kubenets (VNWARE + VAGRANT + INSTALL DOCKER + INSTALL KUBECTL, KUBEADMIN + FLATTEN NETWORK CALICO NETWORK)
    - Calico Network: giúp chúng ta set up network cho kubenets cluster để các node có thể giao tiếp được với nhau, bên cạnh đó nó còn thêm nhiều tính năng bảo mật
    - Setup sao cho Master Node vs Worker Node ping được với nhau
    - Vagrant có hỗ trợ [install.sh](http://install.sh) (follow theo gì đó để bik cái kubernets + docker các thành phần cần có của Node trong Kubernets)
    - Xóa containerd và restart docker để lấy config mới ?
    - Có 1 câu lệnh giúp t join 1 node worker vào cluster