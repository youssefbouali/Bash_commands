yum install dhcp

cd /etc/dhcp/
cp /usr/share/doc/dhcp*/dhcpd.conf.example dhcpd.conf

subnet 10.10.10.0 netmask 255.255.255.0 {
	range 10.10.10.10 10.10.10.100;
	option domain-name-servers 10.10.10.2;
	option domain-name "ista.ma";
	option routers 10.10.10.1;
	option broadcast-address 10.10.10.255;
	default-lease-time 21600;
	max-lease-time 43200;
}
host Win7 {
	hardawre ethernet 00:0c:29:48:86:70;
	fixed-address 10.10.10.10;
}

systemctl start dhcpd

cat /var/lib/dhcpd/dhcpd.leases