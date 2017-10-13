#!/bin/bash
V=$1
X=`echo $V|sed "s/-/\|/g"`
Ip=`w -h -s|awk '{print "user:"$1,"ip:"$3}'|grep -Ev "$X"|sort -n|uniq`
if test -z "$Ip";then
	echo ok
else
	echo "$Ip"
fi
