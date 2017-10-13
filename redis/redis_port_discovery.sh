#!/bin/bash
#Script_name redis_port_discovery.sh
redis() {
        port=($(sudo netstat -tpln | awk -F "[ :]+" '/redis-server/ && /0.0.0.0/ {print $5}'))
        printf '{\n'
        printf '\t"data":[\n'
            for key in ${!port[@]}
              do
              if [[ "${#port[@]}" -gt 1 && "${key}" -ne "$((${#port[@]}-1))" ]];then
                  socket=`ps aux|grep ${port[${key}]}|grep -v grep|awk -F '=' '{print $10}'|cut -d ' ' -f 1`
                  printf '\t {\n'
                  printf "\t\t\t\"{#REDISPORT}\":\"${port[${key}]}\"},\n"
              else [[ "${key}" -eq "((${#port[@]}-1))" ]]
                  socket=`ps aux|grep ${port[${key}]}|grep -v grep|awk -F '=' '{print $10}'|cut -d ' ' -f 1`
                  printf '\t {\n'
                  printf "\t\t\t\"{#REDISPORT}\":\"${port[${key}]}\"}\n"
              fi
              done
              printf '\t ]\n'
              printf '}\n'
}

REDISCLI=`whereis redis-cli | cut -d " " -f2`
if [[ $# == 1 || $# == 0 ]];then
redis
elif [[ $# == 2 ]];then
echo -e 'canshu error!!!'
elif [[ $# == 3 && $1 -gt 0 ]];then
    case $3 in
        keys)
            result=`$REDISCLI  -p $1 info | grep -w "$2" | grep -w "keys" | awk -F'=|,' '{print $2}'`
            echo $result
        ;;
        expires)
            result=`$REDISCLI -p $1 info | grep -w "$2" | grep -w "keys" | awk -F'=|,' '{print $4}'`
            echo $result
        ;;
        avg_ttl)
            result=`$REDISCLI  -p $1 info | grep -w "$2" | grep -w "avg_ttl" | awk -F'=|,' '{print $6}'`
            echo $result
        ;;
        *)
            echo -e "\033[33mUsage: $0 {port db0 keys|port db0 expires|port db0 avg_ttl}\033[0m" 
        ;;
    esac
else
echo ' $1 is not number!'
fi

