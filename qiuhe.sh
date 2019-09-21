#!/bun/bash
#统计1到100的和
sum=0
i=1
while [ $i -le 100 ]  
do
 sum=$[sum+i]
 let i++
done
echo $sum
