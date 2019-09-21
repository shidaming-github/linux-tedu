#!/bin/bash
#编写脚本测试 172.25.0.0/24 整个网段中哪些主机处于开机状态,哪些主机处于关机状态(多进程版)
#for i in {1..12}
#do
#  ping -c 2 -i 0.2 -W 1 172.25.0.$i > /dev/null
#  if [ $? -eq 0 ];then
#   echo "172.25.0.$i通了"
#   let a++
#  else
#   echo "172.25.0.$i不通"
#   let b++
#  fi
#done
#echo "$a通了,$b不通"
i=1
while [ $i -le 12 ]
do
 ping -c2 -i0.3 -W1 172.25.0.$i &> /dev/null
 if [ $? -eq 0 ];then
  echo "172.25.0.$i is up"
 else
  echo "172.25.0.$i is down"
 fi
 let i++
done
