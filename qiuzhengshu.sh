#!/bin/bash
#显示出2000内被177整除的数字
for i in {1..2000}
do
  a=$[i%177]
  if [ $a -eq 0 ];then
    echo $i
  fi
done
