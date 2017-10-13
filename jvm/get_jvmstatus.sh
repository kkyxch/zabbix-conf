#!/bin/bash 
      
scriptPath=/tmp/package
jvm_info=/tmp/package_path.txt
if [ ! -d $scriptPath  ];then
    mkdir ${scriptPath}
fi
 
cat ${jvm_info}|while read line 
    do
    pid=$(echo $line|awk '{print $1}') 
#    pgRootPath=$(echo $line|awk '{print $2}') 
    packageName=$(echo $line|awk '{print $2}') 
#    if [[ -d $pgRootPath/tomcat ]];then
#    pid=$(cat $pgRootPath/tomcat/tomcat.pid) 
#    else
    #mainPath=$(find $pgRootPath -name $MAINCLASS) 
    #appName=$(echo ${mainPath##*classes/}|sed 's#/#.#g'|sed 's#.class##g') 
#    pid=$(ps -fC java|grep "$packageName"|awk '{print $2}') 
#    fi
#    javaHome=/opt/jdk1.8.0_92
    jstat_path=`whereis jstat|awk '{print$2}'`
    echo -------------------------------$pid 
    sleep 5 
    echo gcnew > $scriptPath/$packageName 2>/dev/null
    $jstat_path -gcnew $pid >> $scriptPath/$packageName 2>/dev/null
    echo gcutil >> $scriptPath/$packageName 2>/dev/null
    $jstat_path -gcutil $pid >> $scriptPath/$packageName 2>/dev/null
    echo gcnewcapacity >> $scriptPath/$packageName 2>/dev/null
    $jstat_path -gcnewcapacity $pid >> $scriptPath/$packageName 2>/dev/null
            echo gccapacity >> $scriptPath/$packageName 2>/dev/null
    $jstat_path -gccapacity $pid >> $scriptPath/$packageName 2>/dev/null
            echo gc >> $scriptPath/$packageName 2>/dev/null
    $jstat_path -gc $pid >> $scriptPath/$packageName 2>/dev/null
            echo class >> $scriptPath/$packageName 2>/dev/null
    $jstat_path -class $pid >> $scriptPath/$packageName 2>/dev/null
    echo cpu >> $scriptPath/$packageName 2>/dev/null
    echo -e "CPU\n$( ps aux|grep $pid|grep -v grep|awk '{print $3}')" >> $scriptPath/$packageName 2>/dev/null
    echo mem >> $scriptPath/$packageName 2>/dev/null
    echo -e "MEM\n$( ps aux|grep $pid|grep -v grep|awk '{print $6}')" >> $scriptPath/$packageName 2>/dev/null
done
