#!/bin/bash
/usr/bin/curl -I http://127.0.0.1:8080/stats 2>&1|grep Unauthorized >/dev/null 2>&1 && echo "haproxy" || exit 7
