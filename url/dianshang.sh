#!/bin/bash
rcm() {
RETURN=`curl -o /dev/null -s "http://rcm.can-tv.cn/Admin/Index/login" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
erp() {
RETURN=`curl -o /dev/null -s "http://erp.can-tv.cn/index.php" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
oa() {
RETURN=`curl -o /dev/null -s "http://oa.can-tv.cn:8081" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
crm() {
RETURN=`curl -o /dev/null -s "http://crm.can-tv.cn/index.php" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
dmsadmin() {
RETURN=`curl -o /dev/null -s "http://admin.dms.can-tv.cn/Admin/Index/login" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
shouye() {
RETURN=`curl -o /dev/null -s "http://www.can.tv/index.php" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}


case $1 in
    rcm) rcm;;
    erp) erp;;
    oa) oa;;
    crm) crm;;
    dmsadmin) dmsadmin;;
    shouye) shouye;;
esac

