#!/bin/bash
#nosql数据库集群,redis服务{51..56},57做管理服务器
#51到56配置redis服务
for i in 51 52 53 54 56 57 
do
    scp -o StrictHostKeyChecking=no /linux-soft/03/redis/redis-4.0.8.tar.gz root@192.168.4.$i:/root
    ssh -X root@192.168.4.$i "yum -y install gcc;
                              tar -xf redis-4.0.8.tar.gz;
                              cd redis-4.0.8/;
                              make && make install;
                              clear;
                              sleep 1;
                              echo '此处六次回车';
                              ./utils/install_server.sh;
                              /etc/init.d/redis_6379 stop;
                              sed -i \"70s/127.0.0.1/192.168.4.$i/\" /etc/redis/6379.conf;
                              /etc/init.d/redis_6379 start;
                              ss -plunt |grep 6379;
                              "
done
#在192.168.4.57上做管理主机:
scp /linux-soft/03/redis/redis-4.0.8.tar.gz root@192.168.4.58:/root
scp /linux-soft/03/redis/redis-3.2.1.gem root@192.168.4.58:/root
ssh root@192.168.4.58 "yum -y install rubygems;
                       gem  install redis-3.2.1.gem;
                       mkdir /root/bin;
                       tar -xf redis-4.0.8.tar.gz;
                       cd redis-4.0.8/src;
                       cp redis-trib.rb /root/bin;
                       chmod +x /root/bin/redis-trib.rb
                      "
#启用集群配置:
for i in 51 52 53 54 56 57
do
  ssh root@192.168.4.$i "sed -i \"815s/#//;823s/#//;829s/#//;829s/15000/5000/\" /etc/redis/6379.conf;
                           redis-cli -h 192.168.4.$i -p 6379 shutdown;
                           /etc/init.d/redis_6379 start;
                           ss -plunt |grep redis-server
                          "
done
#创建集群
ssh -X root@192.168.4.58 "echo '此处回车后输入yes';
                          redis-trib.rb create --replicas 1 192.168.4.51:6379 192.168.4.52:6379 192.168.4.53:6379 192.168.4.54:6379 192.168.4.56:6379 192.168.4.57:6379;
                          redis-trib.rb info 192.168.4.51:6379;
                          redis-trib.rb check 192.168.4.51:6379
                         "

