#iptables
/sbin/iptables -F
/sbin/iptables -X
/sbin/iptables -P INPUT DROP
/sbin/iptables -P OUTPUT ACCEPT
/sbin/iptables -P FORWARD DROP
/sbin/iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A INPUT -p icmp -j ACCEPT
/sbin/iptables -A INPUT -i lo -j ACCEPT
/sbin/iptables -A INPUT -s 10.182.1.0/24 -j ACCEPT
#/sbin/iptables -A INPUT -s 61.50.105.74/32 -m state --state NEW -m tcp -p tcp --dport 51888 -j ACCEPT
/sbin/iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
