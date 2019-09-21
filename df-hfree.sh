#!/bin/bash
#实时监控本机内存和硬盘剩余空间,剩余内存小于 500M、根分区剩余空间小于 1000M 时,发送报警邮件给root 管理员
#提取根分区剩余空间
disk_size=$(df / |awk '/\//{print $4}')
#提取内存剩余空间
mem_size=$(free |awk '/Mem/{print $4}')
while :
do
 if [ $mem_size -le 1024000 -a $disk_size -le 512000 ];then
    echo "资源不足" |mail -s "报警" root
 fi
 exit
done
