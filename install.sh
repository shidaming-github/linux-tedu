#!/bin/bash
yum -y install gcc pcre-devel openssl-devel
useradd ngnix
tar -xf /root/nginx-1.12.2.tar.gz
cd nginx-1.12.2
./configure --user=nginx --group=nginx &>/dev/null
make &>/dev/null
make install &>/dev/null
