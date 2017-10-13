#!/bin/bash
pool_name=$(echo $1|awk -F ':' '{print $1}')
server_name=$(echo $1|awk -F ':' '{print $2}')
metric=$2
stat_socket=/opt/haproxy/var/lib/haproxy/stats
show_stat(){
echo "show stat"|sudo socat stdio unix-connect:$stat_socket
}
 
case $metric in
          qcur)
              #current queued requests
              if [ "$server_name" != "FRONTEND" ];then
                 show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $3}'
              else
                  echo 0
              fi
             ;;
          qmax)
              #max queued requests
              if [ "$server_name" != "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $4}'
              else
                  echo 0
              fi
             ;;
          scur)
              #current sessions
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $5}'
             ;;
          smax)
              #max sessions
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $6}'
             ;;
          slim)
              #sessions limit
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $7}'
             ;;
          stol)
              #total sessions
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $8}'
             ;;
           bin)
              #bytes in 
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $9}'
             ;;
          bout)
              #bytes out
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $10}'
             ;;
          dreq)
              #denied requests
              #only FRONTEND and BACKEND has this field
              if [ "$server_name" == "FRONTEND" -o "$server_name" == "BACKEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $11}'
              else 
                 echo 0
              fi
             ;;
         dresp)
              #denied responses
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $12}'
             ;;
          ereq)
              #request errors
              #only FRONTEND has this field
              if [ "$server_name" == "FRONTEND" ];then
                 show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $13}'
              else
                 echo 0
              fi
             ;;
          econ)
              #connection errors
              #FRONTEND has not this field
              if [ "$server_name" != "FRONTEND" ];then
                 show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $14}'
              else
                 echo 0
              fi
             ;;
         eresp)
              #response errors
              #FRONTEND has not this field
              if [ "$server_name" != "FRONTEND" ];then
                 show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $15}'
              else
                 echo 0
              fi
             ;;
        status)
              #status
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $18}'
              ;;
       chkfail)
              #number of failed checks
              #FRONTEND and BACKEND has not this field
              if [ "$server_name" == "FRONTEND" -o "$server_name" == "BACKEND" ];then
                 echo 0
              else
                 show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $22}'
              fi
              ;;
       chkdown)
              #number of UP->DOWN transitions
              #FRONTEND has not this field will return 0
              if [ "$server_name" != "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $23}'
              else
                 echo 0
              fi
              ;;
       lastchg)
              #last status change in seconds
              #FRONTEND has not this field will return 0
              if [ "$server_name" != "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $24}'
              else
                 echo 0
              fi
              ;;
      downtime)
              #total downtime in seconds
              #FRONTEND has not this field will return 0
              if [ "$server_name" != "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $25}'
              else
                 echo 0
              fi
              ;;
         lbtot)
              #total number of times a server was selected
              #FRONTEND has not this field
              if [ "$server_name" != "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $31}'
              else
                 echo 0
              fi
              ;;
          rate)
              #number of sessions per second over last elapsed second
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $34}'
              ;;
    rate_limit)
              #limit on new sessions per second
              #only FRONTEND has this field
              if [ "$server_name" == "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $35}'
              else
                  echo 0
              fi
              ;;
      rate_max)
              #max number of new sessions per second
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $36}'
              ;;
  check_status)
              #status of last health check  
              if [ "$server_name" == "FRONTEND" -o "$server_name" == "BACKEND" ];then
                 echo "NULL"
              else
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $37}'
              fi
              ;;
      hrsp_1xx)
              #http response with 1xx code
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $40}'
              ;;
      hrsp_2xx)
              #http response with 2xx code
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $41}'
              ;;
      hrsp_3xx)
              #http response with 3xx code
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $42}'
              ;;
      hrsp_4xx)
              #http response with 4xx code
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $43}'
              ;;
      hrsp_5xx)
              #http response with 5xx code
              show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $44}'
              ;;
      req_rate)
              #HTTP requests per second over last elapsed second
              #only FRONTEND has this field,others will return 0
              if [ "$server_name" == "FRONTEND" ];then
                 show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $47}'
              else
                 echo 0
              fi
              ;;
  req_rate_max)
              #max number of HTTP requests per second observed
              #only FRONTEND has this field,others will return 0
              if [ "$server_name" == "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $48}'
              else
                  echo 0
              fi
              ;;
       req_tot)
              #total number of HTTP requests recevied
              #only FRONTEND has this field,others will return 0
              if [ "$server_name" == "FRONTEND" ];then
                  show_stat|awk -F"," '$1=="'$pool_name'"&&$2=="'$server_name'"{print $49}'
              else
                  echo 0
              fi
              ;;
             *)
               echo "please input the correct argument"
              ;; 
esac
