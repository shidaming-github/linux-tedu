#!/bin/bash
yum -y install  bind-chroot bind
cp  /etc/named.conf  /etc/named.bak
sed -i '11,48d' /etc/named.conf
echo "view "nsd" {
  match-clients  { 192.168.4.207;  };
  zone "tedu.cn" IN {
        type master;
        file "tedu.cn.zone";
  };
  zone "sina.com" IN {
        type master;
        file "sina.com.other";
  };
};" >> /etc/named.conf
echo "view "abc" {
  match-clients  { 192.168.4.7;  };
  zone "tedu.cn" IN {
        type master;
        file "tedu.cn.other";
  };
  zone "sina.com" IN {
        type master;
        file "sina.com.zone";
  };
};" >> /etc/named.conf
echo "view "other" {
  match-clients  {  any;  };
  zone "tedu.cn" IN {
        type master;
        file "tedu.cn.other";
  };
  zone "sina.com" IN {
        type master;
        file "sina.com.other";
  };
};" /etc/named.conf
cp -p /var/named/named.localhost /var/named/tedu.cn.zone
sed -i '8,10d' /var/named/tedu.cn.zone
echo "tedu.cn.     NS  svr7
svr7    A     192.168.4.207
www     A     192.168.4.100" >> /var/named/tedu.cn.zone
cp -p /var/named/tedu.cn.zone /var/named/sina.com.zone
sed -i 's/tedu\.cn/sina\.com/;s/207/7/' /var/named/sina.com.zone
cp -p /var/named/tedu.cn.zone /var/named/tedu.cn.other
sed -i 's/100/200/' /var/named/tedu.cn.other
sed -i 's/100/200/' /var/named/sina.com.other
systemctl restart named
systemctl enable named

