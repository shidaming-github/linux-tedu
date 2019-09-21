#!/bin/bash
#显示进度条
jindu(){
while :
do
  echo -n "#"
  sleep 0.2
done
}
jindu &
cp -a $1 $2
killall $!
echo "拷贝完成"
