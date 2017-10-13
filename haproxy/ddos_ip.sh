#!/bin/bash
cat /dev/null > /tmp/ipchange.log
wipfile="/tmp/whitelist.log"
echo "show acl /opt/haproxy/conf/blacklist.lst" | sudo /usr/bin/socat unix-connect:/opt/haproxy/var/lib/haproxy/stats -|grep 0x > /tmp/ipchangetmp.log
checklist(){
for h in `cut -d " " -f 2 /tmp/ipchangetmp.log`;
do
grep $h ${wipfile} &>/dev/null || echo 黑名单 $h && echo 白名单 $h >> /tmp/ipchange.log
done
cat /tmp/ipchange.log
}
if [ -s /tmp/ipchangetmp.log ];then
checklist
fi
