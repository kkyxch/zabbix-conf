#!/bin/bash 
      
packagePath=/tmp/package_path.txt 
echo -n >$packagePath 
      
for i in `ps -fC java|tail -n +2|grep -v 'flume'|awk '{print $2}'`; 
    do
    pgrootpath=`ls -l /proc/$i/cwd|awk '{print $NF}'` 
    if [[ -r $pgrootpath/appconfig ]] && [  `grep ^packagename= $pgrootpath/appconfig|wc -l`==1 ];then
        packagename=$(grep ^packagename= $pgrootpath/appconfig 2>/dev/null|awk -F'"' '{print $2}') 
    elif [[ -r $pgrootpath/webconfig ]] && [  `grep ^packagename= $pgrootpath/webconfig|wc -l`==1 ];then
        packagename=$(grep ^packagename= $pgrootpath/webconfig 2>/dev/null|awk -F'"' '{print $2}') 
    else
        packagename=$(basename $pgrootpath).jar
    fi
      
    echo "$i $packagename $pgrootpath" >> $packagePath 
 done
