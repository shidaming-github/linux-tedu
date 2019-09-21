#!/bin/bash
#安全检测脚本
awk '/Invalid user/{print $10}' /var/log/secure |awk '{ip[$1]++}END{for(i in ip){print ip[i],i }}'
awk '/Failed password/{print $11}' /var/log/secure |awk '{ip[$1]++}END{for(i in ip){print i,ip[i]}}'
