#!/bin/bash
wipfile="/tmp/whitelist.log"
TIME=`date +%Y%m%d%H%M%S`
DDOSLOG="/tmp/ddos"
HALOG="/opt/haproxy/var/log/haproxy.log"
#SJC_TIME=$((${TIMESTAMP}-60))
SJC="${TIME:0:8}_ddos.log"
mail="smc@cantv.cn"
title="ddos_ip_info_`hostname`"
#cat /dev/null > ${wipfile}
cat /dev/null > /tmp/ddos.log
echo "show acl /opt/haproxy/conf/blacklist.lst" | sudo /usr/bin/socat unix-connect:/opt/haproxy/var/lib/haproxy/stats -|grep 0x |grep -Ev "218.75.175.9|113.113.126.43|113.113.121.219"> /tmp/ddostmp.log

if [ ! -d ${DDOSLOG} ];then
    mkdir ${DDOSLOG}
fi


ipfenxi(){

ip=$1

address=${ip%/*}
mlen=${ip#*/}

declare -i FULL_MASK_INT=4294967295 
declare -i MASK_LEN=$mlen
declare -i LEFT_MOVE="32 - ${MASK_LEN}" 
declare -i N="${FULL_MASK_INT} << ${LEFT_MOVE}" 
declare -i H1="$N & 0x000000ff" 
declare -i H2="($N & 0x0000ff00) >> 8" 
declare -i L1="($N & 0x00ff0000) >> 16" 
declare -i L2="($N & 0xff000000) >> 24" 
mask="$L2.$L1.$H2.$H1"
ip="$address $mask"

all=(${ip//[!0-9]/ })  

get_addr () {         
    op='&'         
    unset net          
    while [ "$5" ]; do                
    num=$(( $1 $op ($5 $op1 $arg) ))               
    shift               
    net="$net.$num"                             
    done
}
get_addr ${all[@]}                  

all=(${net//./ })
n=$((2**(32-$mlen)))
n1=${all[0]}
n2=${all[1]}
n3=${all[2]}
n4=${all[3]}
for((i=0;i<n;i++))
do
    if [ $n4 -eq 256 ];then
        n4=0
        ((n3++))
        if [ $n3 -eq 256 ];then
            n3=0
            ((n2++))
                if [ $n2 -eq 256 ];then
                        n2=0
                        ((n1++))
            fi

        fi    
    fi

    echo "$n1.$n2.$n3.$n4"
        ((n4++))
done
}

checklist(){
for h in `cut -d " " -f 2 /tmp/ddostmp.log`;
do
#grep $h ${wipfile} &>/dev/null || echo 0x $h >> /tmp/ddos.log
if [  -z `grep $h ${wipfile}` ]; then
    echo "0x $h" >> /tmp/ddos.log
    sudo tac "${HALOG}" | grep $h | head -200 | awk '{print $7,$6,$9,$18,$19"\""}' > /tmp/ddosinfo
    ddosinfo=`cat /tmp/ddosinfo`
    current=`head -1 /tmp/ddosinfo`
    age_60=`sudo tail -1  ${DDOSLOG}/${SJC} 2>/dev/null`
    if [ "${current}" != "${age_60}" ]; then
        sudo sh -c "echo ${current} >> ${DDOSLOG}/${SJC}"
        sh /opt/sh/sendmail.sh ${mail} ${title} "${ddosinfo}" &>/dev/null
        curl -s --connect-timeout 10 -d token=869493ecfd56b5619e8f99ee057c5514  -d script=ddos_info -d type=1 -d status=1 -d remarks="`hostname` ${current}"  http://10.182.1.112/getdata.php
        find ${DDOSLOG}  -type d -ctime +30 | xargs rm -rf
    fi
fi
done
cat /tmp/ddos.log
exit 0
}


###start###
if [ -s /tmp/ddostmp.log ];then
#iplist="/opt/haproxy/conf/whitelist.lst"
#for i in `cat ${iplist}`;do
#ipfenxi $i >> ${wipfile}
#done
checklist
fi
