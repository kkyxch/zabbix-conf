#!/bin/sh
#$Id: check_perc5i.sh, v0.2 2008/4/15 weithenn Exp $
#Check RAID Card PERC 5/i VD and PD State
HOSTNAME=`/bin/hostname`
DATE=`date +%F" "%T`
cd /opt/zabbix
CARD=`./MegaCli -AdpAllInfo -aALL |grep "Product Name" | awk -F":" '{print $NF}'`
VDSTATE1=`/opt/zabbix/MegaCli -cfgdsply -aALL | grep "State" | grep -v "Foreign State: None"`
VDSTATE2=`./MegaCli -AdpAllInfo -aALL | grep "Degraded"`
VDSTATE3=`./MegaCli -AdpAllInfo -aALL | grep "  Offline"`
PDSTATE1=`./MegaCli -cfgdsply -aALL | grep "Online" | wc -l | sed 's/       //'`
PDSTATE2=`./MegaCli -cfgdsply -aALL | grep "Rebuild" | wc -l | sed 's/       //'`
PDSTATE3=`./MegaCli -AdpAllInfo -aALL | grep "Critical Disks"`
PDSTATE4=`./MegaCli -AdpAllInfo -aALL | grep "Failed Disks"`
PDSTATE5=`./MegaCli -AdpAllInfo -aALL | grep "Failed Disks"|awk '{print $NF}'`
>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "<html>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "<title>check-driver</title>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "<head>##### Check Time #####</head>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "<br>Current Time is   :$DATE</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "<br>##### Host Informationi #####</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "Host              : $HOSTNAME</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "Raid Card         :$CARD</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "<br>##### Virtual Disk State #####</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "Virtual Disk $VDSTATE1</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "$VDSTATE2</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "$VDSTATE3</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "<br>##### Physical Disk State #####</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "Online Disk       : ${PDSTATE1}</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "Rebuild Disk      : ${PDSTATE2}</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "$PDSTATE3</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "$PDSTATE4</br>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
echo "</html>" >>/usr/lib/vmware/hostd/docroot/checkdriver.html
>/opt/zabbix/CmdTool.log
>/opt/zabbix/MegaSAS.log
