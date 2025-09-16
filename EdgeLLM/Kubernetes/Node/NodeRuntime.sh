#!/bin/bash
set -e

# 安装依赖
apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release

# 添加 Docker GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# 添加 Docker 仓库
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" \
| tee /etc/apt/sources.list.d/docker.list > /dev/null

# 安装 Docker
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 配置 Docker
cat > /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": [
    "https://docker.1ms.run",
    "https://doublezonline.cloud",
    "https://dislabaiot.xyz",
    "https://docker.fxxk.dedyn.io",
    "https://dockerpull.org",
    "https://docker.unsee.tech",
    "https://hub.rat.dev",
    "https://docker.1panel.live",
    "https://docker.nastool.de",
    "https://docker.zhai.cm",
    "https://docker.5z5f.com",
    "https://a.ussh.net",
    "https://docker.udayun.com",
    "https://hub.geekery.cn"
  ],
  "insecure-registries": ["kubernetes-register.sswang.com"],
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

systemctl daemon-reload
systemctl restart docker
systemctl enable docker

# 安装 cri-dockerd
wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.16/cri-dockerd-0.3.16.amd64.tgz
tar xf cri-dockerd-0.3.16.amd64.tgz
mv cri-dockerd/cri-dockerd /usr/local/bin/
cri-dockerd --version

# 配置 systemd service
cat > /etc/systemd/system/cri-dockerd.service <<EOF
[Unit]
Description=CRI Interface for Docker Application Container Engine
Documentation=https://docs.mirantis.com
After=network-online.target firewalld.service docker.service
Wants=network-online.target
Requires=cri-docker.socket

[Service]
Type=notify
ExecStart=/usr/local/bin/cri-dockerd \
  --pod-infra-container-image=registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.10 \
  --network-plugin=cni \
  --cni-conf-dir=/etc/cni/net.d \
  --cni-bin-dir=/opt/cni/bin \
  --container-runtime-endpoint=unix:///var/run/cri-dockerd.sock \
  --docker-endpoint=unix:///var/run/docker.sock
ExecReload=/bin/kill -s HUP \$MAINPID
Restart=always
RestartSec=2
StartLimitBurst=3
StartLimitInterval=60s
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/cri-docker.socket <<EOF
[Unit]
Description=CRI Docker Socket for the API
PartOf=cri-dockerd.service

[Socket]
ListenStream=/var/run/cri-dockerd.sock
SocketMode=0660
SocketUser=root
SocketGroup=docker

[Install]
WantedBy=sockets.target
EOF

systemctl daemon-reload
systemctl enable cri-dockerd.service
systemctl restart cri-dockerd.service

# 验证
ls /var/run | grep docker
