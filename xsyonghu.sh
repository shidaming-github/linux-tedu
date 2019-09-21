#!/bin/bash
#找出使用bash的用户,按照"名字--->密码"的格式显示


#用awk编写
#a=`awk -F: '/bash$/{print $1}' /etc/passwd`
#for i in $a
#do
# b=`grep $i /etc/shadow | awk -F: '{print $1 "--->" $2}'`
# echo $b
#done


#用sed编写
a=`sed -n '/bash$/s/:.*//p' /etc/passwd`
for i in $a
do
  b=`grep $i /etc/shadow`
  c1=${b#*:}
  c2=${c1%%:*}
  echo "$i ---> $c2"
done

