#!/bin/bash 
#scripts for tcp status 
function SYNRECV { 
/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'SYN-RECV' > /tmp/SYNRECV && awk '{print $2}' /tmp/SYNRECV || echo 0
} 
function ESTAB { 
/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'ESTAB' > /tmp/ESTAB && awk '{print $2}' /tmp/ESTAB || echo 0
} 
function FINWAIT1 { 
/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'FIN-WAIT-1' > /tmp/FINWAIT1 && awk '{print $2}' /tmp/FINWAIT1 || echo 0
} 
function FINWAIT2 { 
/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'FIN-WAIT-2' > /tmp/FINWAIT2 && awk '{print $2}' /tmp/FINWAIT2 || echo 0
} 
function TIMEWAIT { 
/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'TIME-WAIT' > /tmp/TIMEWAIT && awk '{print $2}' /tmp/TIMEWAIT || echo 0
} 
function LASTACK { 
/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'LAST-ACK' > /tmp/LASTACK && awk '{print $2}' /tmp/LASTACK || echo 0
} 
function LISTEN { 
/usr/sbin/ss -ant | awk '{++s[$1]} END {for(k in s) print k,s[k]}' | grep 'LISTEN' > /tmp/LISTEN && awk '{print $2}' /tmp/LISTEN || echo 0
} 
$1
