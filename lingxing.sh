#! /bin/bash
#输出*的菱形
tNum=5
for i in $(seq ${tNum})
do
  for j in $(seq $[tNum-i])
  do
    echo -n ' '
  done

  for j in $(seq $[i-1])
  do
    echo -n '*'
  done
  
  echo -n '*'  

  for j in $(seq $[i-1])
  do
    echo -n '*'
  done

  for j in $(seq $[5-i])
  do
    echo -n ' '
  done

  if [ ${i} -eq ${tNum} ];then
    echo
    iNum=$[tNum-1]
    for m in $(seq ${iNum})
    do

      for n in $(seq ${m})
      do
        echo -n ' '
      done

      for n in $(seq $[iNum-m])
      do
         echo -n '*'
      done

      echo -n '*'
      
      for n in $(seq $[iNum-m])
      do
         echo -n '*'
      done

      for n in $(seq ${m})
      do
        echo -n ' '
      done

      echo
    done
  fi

  [ ${i} -ne ${tNum} ] && echo

done
