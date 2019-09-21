#!/bin/bash
#源码安装nginx,mysql,php 需要提前准备所需版本的tar包

echo "# 1. 部署 Nginx"
sleep 1
yum -y install gcc pcre-devel openssl-devel
tar -xf /root/lnmp_soft.tar.gz
useradd -s /sbin/nologin nginx
cd /root/lnmp_soft
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
#开启SSL加密功能和开启4层(tcp/udp)反向代理功能和nginx状态功能
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make
make install
cd ~
clear
echo "# 2. 部署 MySQL&&PHP"
sleep 1  
#mysql ,php 也可以源码安装但要提前准备版本安装包
yum -y install mariadb mariadb-server mariadb-devel
yum -y install php php-mysql php-fpm

clear
#启服务
echo "启服务"
sleep 1
systemctl stop httpd
/usr/local/nginx/sbin/nginx
systemctl start mariadb
systemctl enable mariadb
systemctl start php-fpm
systemctl enable php-fpm

clear
#构建LNMP平台,实现与PHP动静分离
sed -i '65,71s/#//;70s/fastcgi_params/fastcgi.conf/;69d' /usr/local/nginx/conf/nginx.conf
#将PHP脚本cp到nginx网站根目录下(用来验证)
cp /root/lnmp_soft/php_scripts/mysql.php /usr/local/nginx/html/
#认证提示符信息和认证的密码文件
sed -i '36a auth_basic "Input Password:";\nauth_basic_user_file "/usr/local/nginx/pass"; ' /usr/local/nginx/conf/nginx.conf
clear
echo "生成密码文件，创建用户及密码"
sleep 1
yum -y install httpd-tools
read -p "请输入用户名:" user
htpasswd -c /usr/local/nginx/pass $user

#设置加密网站的虚拟主机
cd /usr/local/nginx/conf
#生成私钥
openssl genrsa > cert.key
#生成证书
openssl req -new -x509 -key cert.key > cert.pem
cd ~
sed -i '99,116s/#//;101s/localhost/www.a.com/' /usr/local/nginx/conf/nginx.conf
/usr/local/nginx/sbin/nginx -s reload 
