#!/bin/bash 
      
TABLESPACE=`awk '{print $2}' /tmp/package_path.txt` 
COUNT=`echo "$TABLESPACE" |wc -l` 
INDEX=0 
echo '{"data":['
echo "$TABLESPACE" | while read LINE;
do
echo -n '{"{#TABLENAME}":"'$LINE'"}'
INDEX=`expr $INDEX + 1` 
if [ $INDEX -lt $COUNT ]; then
    echo ','
fi
done
echo ']}'
