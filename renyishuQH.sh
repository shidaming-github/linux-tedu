#!/bin/bash
#输入任意3个数字,求和
read -p "请输入任意数字" n
read -p "请输入任意数字" a
read -p "请输入任意数字" b
num=`echo $n+$a+$b | bc`
echo $num
