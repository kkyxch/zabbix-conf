#!/bin/bash
#删除cmsapi三日前的日志文件
source /etc/profile
cd /data/www-log/cmsapiRuntime/Logs && find ./ -type f -mtime +4|xargs -i rm -rf {}

cd /opt/nginx/logs && find ./ -type f -mtime +3|grep -v pid|xargs -i rm -rf {}
