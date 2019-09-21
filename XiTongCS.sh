#!/bin/bash
cat /etc/redhat-release
cat /etc/hostname
ifconfig eth0 | awk '/inet /{print "本机ip是"$2}'
uptime | awk '{print "cpu平均负载是" $10,$11,$12}'
free -m | awk '/^Mem/{print "内存剩余容量是" $4"m"}'
df -h | awk '/\/$/{print "硬盘剩余空间是" $4}'
ifconfig eth0 |awk '/RX p/{print "网卡eth0接收的数据量是" $5 "字节"}'
ifconfig eth0 |awk '/TX p/{print "网卡eth0发送的数据量是" $5 "字节"}'
p=`rpm -qa |wc -l`
echo "当前主机安装的软件包数量是 $p 个"
awk '{x++}END{print "当前拥有账户总数是"x"个" }' /etc/passwd
x=`who |wc -l`
echo "当前登录账户数量是$x 个"
psn=`ps aux |wc -l`
echo "主机运行的进程有$psn 个"
