#!/bin/bash
source /etc/profile
cd /opt/nginx/logs
Logday=`date -d "1 day ago" +%Y%m%d`
for h in *.${Logday};do
tar czvf $h.tgz $h
done
lastday=`date -d "2 day ago" +%Y%m%d`
rm -rf *.${lastday}.tgz
