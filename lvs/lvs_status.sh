#!/bin/bash
#function AllConn {
#        sudo /sbin/ipvsadm -Ln | sed -n '2,$p' |awk '{print $5 + $6}'|awk 'BEGIN{sum=0}{sum+=$1}END{print sum}'
#}
#function InConn {
#        sudo /sbin/ipvsadm -Ln | sed -n '2,$p' |awk '{print $6}'| awk 'BEGIN{sum=0}{sum+=$1}END{print sum}'
#}
#function ActConn {
#     sudo /sbin/ipvsadm -Ln | sed -n '2,$p' |awk '{print $5}' |awk 'BEGIN{sum=0}{sum+=$1}END{print sum}'
#}
## Run the requested function




#lvs链接总数
function lvs_conn_total {
    wc -l /proc/net/ip_vs_conn|awk '{print $1}'
}
#lvs每秒入包个数
function lvs_pps_in {
    tail -1 /proc/net/ip_vs_stats | /usr/bin/awk '{print strtonum("0x"$1),strtonum("0x"$2), strtonum("0x"$3), strtonum("0x"$4),strtonum("0x"$5)}'|awk '{print $2}'
}
#lvs每秒入流量
function lvs_bps_in {
    tail -1 /proc/net/ip_vs_stats | /usr/bin/awk '{print strtonum("0x"$1),strtonum("0x"$2), strtonum("0x"$3),strtonum("0x"$4), strtonum("0x"$5)}'|awk '{print $4}'
}

case $1 in
    lvs_conn_total) lvs_conn_total;;
    lvs_pps_in) lvs_pps_in;;
    lvs_bps_in) lvs_bps_in;;
    *) echo 'lvs_conn_total|lvs_pps_in|lvs_bps_in'
esac
