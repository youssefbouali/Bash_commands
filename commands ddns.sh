nano /etc/named.conf
	allow-update { 192.168.0.2; };

nano /etc/dhcp/dhcpd.conf
ddns-update-style interim;
ddns-updates on;
allow-client-updates;
ddns-domainname="ista.ma";
ddns-rev-domain="0.168.192.in-addr.arpa";
authoritative
update-static-leases on;
zone ista.ma {
 primary 192.168.0.2;
}
zone 0.168.192.in-addr.arpa {
 primary 192.168.0.2;
}

systemctl restart named
systemctl restart dhcpd