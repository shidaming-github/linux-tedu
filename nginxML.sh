#!/bin/bash
case $1 in
sd)
  /usr/local/nginx/sbin/nginx ;;
st)
 /usr/local/nginx/sbin/nginx -s stop ;;
re)
   /usr/local/nginx/sbin/nginx -s reload ;;
V)
   /usr/local/nginx/sbin/nginx -V  ;;
ss)
   ss -plunt | grep nginx ;;
*)
  echo "nginx服务sd起服务|st关服务|re重新加载|V查看|ss查看端口" ;;
esac
