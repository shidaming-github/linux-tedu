#!/bin/bash
yum -y install gcc pcre-devel openssl-devel
useradd -s /sbin/nologin nginx
tar -xf /root/lnmp_soft.tar.gz
cd /root/lnmp_soft
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
#安装SSL加密模块,开启TCP/UDP代理模块,开启status服务器状态信息页面
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make
make install
cd ~
systemctl stop httpd
/usr/local/nginx/sbin/nginx


