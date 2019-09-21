#!/bin/bash
yum -y install  bind-chroot bind
cp  /etc/named.conf  /etc/named.bak
sed -i '11,12d;14,48d' /etc/named.conf
sed -i '14s/\./tedu.cn/;15s/hint/master/;16s/"named.ca"/"tedu.cn.zone"/' /etc/named.conf
cd /var/named/
cp -p named.localhost tedu.cn.zone
sed -i '8s/^/tedu.cn./;8s/@/svr7/' tedu.cn.zone
sed -i '9s/^/svr7/;9s/ 127.0.0.1/172.25.0.10/;10c www  A  192.168.2.200' tedu.cn.zone
systemctl restart named
systemctl enable named

