#!/bin/bash
#随机8位密码
x=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
for i in {1..8}
do
#获取0~61之间的随机数字
n=$[RANDOM%62]
#获取1位随机字符
p=${x:n:1}  
#将每次获取的随机字符赋值给变量pass
pass=$pass$p 
done
echo $pass
