root@master:~# cat /etc/netplan/50-cloud-init.yaml
# This file is generated from information provided by the datasource.  Changes
# to it will not persist across an instance reboot.  To disable cloud-init's
# network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}
network:
    ethernets:
        ens33:
          addresses: [192.168.1.15/24]
          gateway4: 192.168.1.1
          dhcp4: false
          nameservers:
            addresses: [114.114.114.114, 8.8.8.8]
    version: 2
    renderer: NetworkManager
root@master:~# sudo netplan apply
