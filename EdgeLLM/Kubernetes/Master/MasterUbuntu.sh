#!/bin/bash
set -e

# 1. 设置主机名（不同节点手动改）
hostnamectl set-hostname "k8smaster"

# 2. 修改 /etc/hosts
cat >> /etc/hosts << EOF
10.112.203.49 master
192.168.31.225 node1
192.168.31.226 node2
EOF

# 3. 设置时区和时间同步
timedatectl set-timezone Asia/Shanghai
apt update && apt install -y ntpdate ntpsec-ntpdate
ntpdate ntp.aliyun.com
(crontab -l 2>/dev/null; echo "0 0 * * * ntpdate ntp.aliyun.com") | crontab -

# 4. 系统内核参数
cat << EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
modprobe overlay
modprobe br_netfilter
cat << EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sysctl --system

# 5. 安装 IPVS
apt install -y ipset ipvsadm
cat << EOF | tee /etc/modules-load.d/ipvs.conf
ip_vs
ip_vs_rr
ip_vs_wrr
ip_vs_sh
nf_conntrack
EOF
modprobe ip_vs
modprobe ip_vs_rr
modprobe ip_vs_wrr
modprobe ip_vs_sh
modprobe nf_conntrack
lsmod | grep ip_vs

# 6. 关闭 swap
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
