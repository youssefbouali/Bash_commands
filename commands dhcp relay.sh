subnet 20.20.20.0 netmask 255.255.255.0 {
	range 20.20.20.20 20.20.20.100;
	option domain-name-servers 20.20.20.2;
	option domain-name "ista.ma";
	option routers 20.20.20.2;
	option broadcast-address 20.20.20.255;
	default-lease-time 21600;
	max-lease-time 43200;
}


yum install dhcp*

	nano /etc/sysconfig/dhcrelay
		SERVERS="192.168.0.2"

cp /lib/systemd/system/dhcrelay.service /etc/systemd/system

nano /etc/systemd/system/dhcrelay.service
ExecStart=/usr/sbin/dhcrelay -d --no-pid 192.168.0.2

systemctl enable dhcrelay.service

	dhcrelay -q 192.168.0.2

systemctl restart dhcrelay.service