echo "zabbix ALL=(root) NOPASSWD:/bin/netstat">>/etc/sudoers

#Disable requiretty

sed -i 's/^Defaults.*.requiretty/#Defaults    requiretty/' /etc/sudoers