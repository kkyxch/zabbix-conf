#!/bin/bash
source /etc/profile
ip=10.182.1.51
cd /opt/nginx/logs
Logday=`date -d "1 day ago" +%Y%m%d`
for i in *.log;do
cat $i >> $i.$ip.${Logday} && cat /dev/null > $i
done
/opt/nginx/sbin/nginx -s reload
