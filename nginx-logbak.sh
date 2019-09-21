#!/bin/bash
date=`date +%Y%m%d`
url=/usr/local/nginx/logs
mv $url/access.log $url/access-$date.log
mv $url/error.log $url/error-$date.log
kill -USR1 $(cat $url/nginx.pid)

