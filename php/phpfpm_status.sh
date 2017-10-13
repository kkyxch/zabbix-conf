#!/bin/bash
Port=10000
Host=127.0.0.1:$Port
PhpPort=$2
if [ ! -n "$PhpPort" ];then
PhpPort=9000
fi
Uri=phpfpm${PhpPort}_status

idle(){
        /usr/bin/curl http://$Host/$Uri 2>/dev/null |grep "idle processes" |awk '{print$3}'
}

total(){
        /usr/bin/curl  http://$Host/$Uri 2>/dev/null |grep "total processes" |awk '{print$3}'
}

active(){
        /usr/bin/curl http://$Host/$Uri 2>/dev/null |grep "active" |awk '{print$3}'|grep -v "process"
}

maxactive(){

        /usr/bin/curl http://$Host/$Uri 2>/dev/null |grep "max active processes:" |awk '{print$4}'
}

listenqueuelen(){
        /usr/bin/curl http://$Host/$Uri 2>/dev/null |grep "listen queue len" |awk '{print$4}'
}

listenqueue(){
        /usr/bin/curl http://$Host/$Uri 2>/dev/null |grep "listen queue:"|grep -vE "len|max"|awk '{print$3}'
}

since(){
        /usr/bin/curl http://$Host/$Uri 2>/dev/null |grep "start since: " |awk '{print$3}'
}

conn(){
        /usr/bin/curl http://$Host/$Uri 2>/dev/null |grep "accepted conn" |awk '{print$3}'
}
$1

