#!/bin/bash
zhjtapi() {
RETURN=$(curl -s -k 'https://api.zhjt.can-tv.cn/v2/heartbeat/check' | grep -oP '((?<=message": ").*?(?=",))')
ERROR=$(curl -s -k 'https://api.zhjt.can-tv.cn/v2/heartbeat/check' | grep -oP '((?<=error": ).*?(?=}))')
[ -z "$RETURN" ] && echo 'message is Null' && exit
[ "$RETURN" != 'ok' ] && echo $ERROR && exit
echo $RETURN
}

#mobi () {
#RETURN=$(curl -s -H "Host: v.cuctv.com" "192.168.1.227/index.php?m=log&c=mon_by&a=check_h5" | grep -oP '((?<=result":).*?(?=,"m))')
#[ -z "$RETURN" ] && echo 555555 && exit
#[[ `echo $RETURN | bc 2>/dev/null` != "$RETURN" ]] && echo 843843 && exit
#[ "$RETURN" != 1 ] && echo $RETURN && exit
#echo $RETURN
#}

case $1 in
    zhjtapi) zhjtapi;;
#    mobi) mobi;;
esac

