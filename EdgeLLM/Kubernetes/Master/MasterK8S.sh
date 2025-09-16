#!/bin/bash
set -e

echo "[1/6] 更新系统..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

echo "[2/6] 添加 Kubernetes GPG key..."
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "[3/6] 配置 apt 源并安装 kubelet/kubeadm/kubectl..."
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "[4/6] 配置 kubelet 使用 systemd cgroup..."
echo 'KUBELET_EXTRA_ARGS="--cgroup-driver=systemd"' | sudo tee /etc/default/kubelet
sudo systemctl enable kubelet

echo "[5/6] 初始化 master 节点..."
sudo kubeadm init \
  --kubernetes-version=1.32.2 \
  --control-plane-endpoint=k8smaster \
  --apiserver-advertise-address=192.168.31.224 \
  --pod-network-cidr=10.244.0.0/16 \
  --service-cidr=10.96.0.0/12 \
  --image-repository=registry.aliyuncs.com/google_containers \
  --cri-socket=unix:///var/run/cri-dockerd.sock \
  --upload-certs \
  --v=5

echo "[6/6] 配置 kubectl..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "[+] Master 节点初始化完成！"
echo ">>> 现在请保存 kubeadm join 的命令，并在 worker 节点上运行 setup-node.sh 后执行。"

echo "[✅] Master 已完成初始化，可以等待节点加入。"
