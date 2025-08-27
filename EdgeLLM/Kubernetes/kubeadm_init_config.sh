# 提前手动拉取镜像（如果网络不稳定）
docker pull registry.aliyuncs.com/google_containers/kube-apiserver:v1.32.8
docker pull registry.aliyuncs.com/google_containers/kube-controller-manager:v1.32.8
docker pull registry.aliyuncs.com/google_containers/kube-scheduler:v1.32.8
docker pull registry.aliyuncs.com/google_containers/kube-proxy:v1.32.8
docker pull registry.aliyuncs.com/google_containers/coredns:v1.11.3
docker pull registry.aliyuncs.com/google_containers/pause:3.10
docker pull registry.aliyuncs.com/google_containers/etcd:3.5.16-0

# 只需要修改自己的IP
kubeadm init \
  --kubernetes-version=1.32.2 \
  --control-plane-endpoint=master \
  --apiserver-advertise-address=192.168.1.15 \
  --pod-network-cidr=10.244.0.0/16 \
  --service-cidr=10.96.0.0/12 \
  --image-repository=registry.aliyuncs.com/google_containers \
  --cri-socket=unix:///var/run/cri-dockerd.sock \
  --upload-certs
