#!/bin/bash
read -p "请输入服务端IP地址:" ip
mkdir /mnt/public
echo "${ip}:/public  /mnt/public  nfs  _netdev  0  0" >> /etc/fstab
mount -a
