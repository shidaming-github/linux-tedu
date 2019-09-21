#!/bin/bash
#构建DHCP服务,指定tftp服务器地址以及网卡引导文件名称
yum -y install dhcp tftp-server
#导入配置文件并修改
cat /usr/share/doc/dhcp*/dhcpd.conf.example >> /etc/dhcp/dhcpd.conf
#定义变量
url1=/etc/dhcp/dhcpd.conf
#删除多余的配置
sed -i '6,51d;61,109d' $url1  
#指定分配网段
sed -i '6s/10.5.5.0/192.168.4.0/;6s/224/0/' $url1
#指定IP地址范围
sed -i '7s/10.5.5.26/192.168.4.100/;7s/10.5.5.30/192.168.4.200/' $url1
#分配DNS地址
sed -i '8s/ns1.internal.example.org/192.168.4.7/;9d' $url1
#指定网关地址
sed -i '9s/10.5.5.1/192.168.4.254/;10d' $url1
#指定下一个服务器tftp服务器地址和指定网卡引导文件名称
sed -i '11a next-server  192.168.4.7;\n filename  "pxelinux.0";' $url1
#启动服务并设开机自启动
systemctl restart dhcpd
systemctl restart tftp
systemctl enable dhcpd
systemctl enable tftp
#安装产生pxelinux.0的软件syslinux
yum -y install syslinux
#拷贝pxelinux.0到tftp默认共享路径下
cp /usr/share/syslinux/pxelinux.0  /var/lib/tftpboot/
#图形添加光驱设备,放入光盘文件,然后挂载到/mnt/下
mount /dev/cdrom  /mnt/
#生成菜单文件
mkdir /var/lib/tftpboot/pxelinux.cfg
cp /mnt/isolinux/isolinux.cfg  /var/lib/tftpboot/pxelinux.cfg/default
#部署图形模块与背景图片,启动内核与驱动程序
cd /mnt/isolinux/
cp vesamenu.c32 splash.png vmlinuz initrd.img /var/lib/tftpboot/
cd /root
#修改菜单文件
url2=/var/lib/tftpboot/pxelinux.cfg/default
sed -i '11s/CentOS 7/NSD 1907 PXE/' $url2
sed -i '65,120d' $url2
sed -i '62a menu default' $url2
sed -i '65c append initrd=initrd.img' $url2
#部署web服务
yum -y install httpd
systemctl  restart httpd
mkdir /var/www/html/centos
#把光盘内容挂载到web网站根目录下
mount /dev/cdrom  /var/www/html/centos
systemctl  restart httpd
systemctl  enable httpd
#实现无人值守安装,生成应答文件
yum -y install system-config-kickstart
#修改yum仓库的标识(redhat7要改,redhat6不用改)
sed -i '1s/local_repo/development/' /etc/yum.repos.d/local.repo
LANG=en  system-config-kickstart
#利用Web服务器将ks.cfg进行共享
cp /root/ks.cfg  /var/www/html/
#指定应答文件位置
sed -i '65s&$& ks=http://192.168.4.7/ks.cfg&' $url2










