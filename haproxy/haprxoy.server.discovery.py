#!/bin/env python
# *- coding uft-8 -*

import json
import subprocess

b1=subprocess.Popen('echo "show stat" | sudo socat /var/lib/haproxy/stats stdio | awk -F ,  \'$2!~/.*END$|svname|^$/{print $2}\'',shell=True,stdout=subprocess.PIPE)
b2=b1.stdout.readlines()
l1=[]
for x in range(len(b2)):
        b3=''.join(b2[x].splitlines())
        b4={"{#BNAME}":b3}
        l1.append(b4.copy())

d={"data":[]}
d['data'] = l1
print json.dumps(d)
