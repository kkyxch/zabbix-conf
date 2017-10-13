#!/bin/bash
appstoreapi() {
RETURN=`curl -o /dev/null -s "http://appstore.can.cibntv.net" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
mam() {
RETURN=`curl -o /dev/null -s "http://admin.mam.can-tv.cn" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
updatetask() {
RETURN=`curl -o /dev/null -s "http://admin.updatetask.can-tv.cn/skips/heartbeat/hello.jsp" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
updateadmindownload() {
RETURN=`curl -o /dev/null -s "http://updateadmindownload.can-tv.cn/httpchk.html" -w %{http_code}`
content=`curl -s "http://updateadmindownload.can-tv.cn/httpchk.html"`
[ -z "$RETURN" -o  "$content" != 'haproxy check' ] && echo 0 && exit
echo $RETURN
}
httpupload() {
RETURN=`curl -o /dev/null -s "http://httpupload.can-tv.cn:8088/httpchk.html" -w %{http_code}`
content=`curl -s "http://httpupload.can-tv.cn:8088/httpchk.html"`
[ -z "$RETURN" -o  "$content" != 'httpupload' ] && echo 0 && exit
echo $RETURN
}
appstoreadmin() {
RETURN=`curl -o /dev/null -s "http://admin.appstore.can-tv.cn" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
cmsadmin() {
RETURN=`curl -o /dev/null -s "http://admin.cms.can-tv.cn/Admin/index" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
bmsadmin() {
RETURN=`curl -o /dev/null -s "http://admin.bms.can-tv.cn/Admin/index" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
tmsadmin() {
RETURN=`curl -o /dev/null -s "http://admin.tms.can-tv.cn" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
tmsapi() {
RETURN=`curl -o /dev/null -s "http://tms.can-tv.cn" -w %{http_code}`
content=`curl -s "http://tms.can-tv.cn"`
[ -z "$RETURN" -o  "$content" != 'Welcome to TMS2.0 API' ] && echo 0 && exit
echo $RETURN
}
bmsapi() {
RETURN=`curl -o /dev/null -s "http://bms.can-tv.cn" -w %{http_code}`
content=`curl -s "http://bms.can-tv.cn"`
[ -z "$RETURN" -o  "$content" != 'welcome bms api sys' ] && echo 0 && exit
echo $RETURN
}
cmsapi() {
RETURN=`curl -o /dev/null -s "http://cms.can-tv.cn" -w %{http_code}`
content=`curl -s "http://cms.can-tv.cn"`
[ -z "$RETURN" -o  "$content" != 'welcome cms api' ] && echo 0 && exit
echo $RETURN
}
imsapi() {
RETURN=`curl -o /dev/null -s "http://ims.can-tv.cn" -w %{http_code}`
content=`curl -s "http://ims.can-tv.cn"`
[ -z "$RETURN" -o  "$content" != 'welcome ims api' ] && echo 0 && exit
echo $RETURN
}
amsadmin() {
RETURN=`curl -o /dev/null -s "http://admin.ams.can-tv.cn/Admin/index" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
tvmalladmin() {
RETURN=`curl -o /dev/null -s "http://admin.tvmall.can-tv.cn" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
biadmin() {
RETURN=`curl -o /dev/null -s "http://admin.bi.can-tv.cn/Admin/index/login" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
updateadmin() {
RETURN=`curl -o /dev/null -s "http://admin.update.can-tv.cn/user/sign_in" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
hezuoapi() {
RETURN=`curl -o /dev/null -s "http://hezuo.can-tv.cn" -w %{http_code}`
content=`curl -s "http://hezuo.can-tv.cn"`
[ -z "$RETURN" -o  "$content" != 'welcome hezuoapi' ] && echo 0 && exit
echo $RETURN
}
hezuoadmin() {
RETURN=`curl -o /dev/null -s "http://admin.hezuo.can-tv.cn/Admin/login/login" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}
zyadmin() {
RETURN=`curl -o /dev/null -s "http://admin.zy.can-tv.cn" -w %{http_code}`
[ -z "$RETURN" ] && echo 0 && exit
echo $RETURN
}

case $1 in
    appstoreapi) appstoreapi;;
    mam) mam;;
    updatetask) updatetask;;
    updateadmindownload) updateadmindownload;;
    httpupload) httpupload;;
    appstoreadmin) appstoreadmin;;
    cmsadmin) cmsadmin;;
    bmsadmin) bmsadmin;;
    tmsadmin) tmsadmin;;
    tmsapi) tmsapi;;
    cmsapi) cmsapi;;
    bmsapi) bmsapi;;
    imsapi) imsapi;;
    amsadmin) amsadmin;;
    tvmalladmin) tvmalladmin;;
    biadmin) biadmin;;
    updateadmin) updateadmin;;
    hezuoapi) hezuoapi;;
    hezuoadmin) hezuoadmin;;
    zyadmin) zyadmin;;
esac



