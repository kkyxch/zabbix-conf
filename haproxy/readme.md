1.haproxy监控需要 安装socat

2.需要zabbix加入/etc/sudoers，两项：

2.1.zabbix ALL=(ALL) NOPASSWD:/usr/bin/socat

2.2.Defaults    !requiretty
