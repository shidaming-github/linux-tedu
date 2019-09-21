#!/bin/bash
#判断对文件的权限
#[ -r $1 ] && echo "有读权限" || echo "没有读权限"
#[ -w $1 ] && echo "有写权限" || echo "没有写权限"
#[ -x $1 ] && echo "有执行权限" || echo "无执行权限"
[ -r $1 ]
if [ $? -eq 0 ];then
 echo "有读权限"
else
 echo "没有读权限"
fi
[ -w $1 ]
if [ $? -eq 0 ];then
   echo "有写权限"
else
   echo "没有写权限"
fi
[ -x $1 ]
if [ $? -eq 0 ];then
  echo "有执行权限"
else
  echo "无执行权限"
fi
