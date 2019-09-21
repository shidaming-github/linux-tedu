#!/bin/bash
rpm -q nfs-utils &> /dev/null
[ $? -gt 0 ]&& yum -y install nfs-utils
mkdir /public
echo "/public    *(ro)" > /etc/exports
systemctl restart nfs-server
systemctl enable nfs-server
#firewall-cmd --set-default-zone=trusted &> /dev/null
