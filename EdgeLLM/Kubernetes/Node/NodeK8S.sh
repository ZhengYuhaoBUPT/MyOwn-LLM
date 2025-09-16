#!/bin/bash
set -e

echo "[1/4] 更新系统..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

echo "[2/4] 添加 Kubernetes GPG key..."
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "[3/4] 配置 apt 源并安装 kubelet/kubeadm/kubectl..."
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "[4/4] 配置 kubelet 使用 systemd cgroup..."
echo 'KUBELET_EXTRA_ARGS="--cgroup-driver=systemd"' | sudo tee /etc/default/kubelet
sudo systemctl enable kubelet

echo "[✅] Worker 节点已准备就绪，请回到 master 节点复制 kubeadm join 命令来加入集群。"
