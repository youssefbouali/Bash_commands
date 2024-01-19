
nano /etc/named.conf

zone "ista.ma" IN {
	type master;
	file "/var/named/forward.ista.ma";
	notify yes;
	allow-transfer { 192.168.0.3; };
}

zone "10.10.10.in-addr.arpa" IN {
	type master;
	file "/var/named/reverse.ista";
	notify yes;
	allow-transfer { 192.168.0.3; };
}

named-checkconf /etc/named.conf

setenforce 0

---nano /etc/sysconfig/network-scripts/ifcfg-ens33 ----
DNS1 = 10.10.10.1

nano /etc/resolv.conf
	nameserver 10.10.10.1

nano /etc/named.conf

zone "ista.ma" IN {
	type slave;
	file "/var/named/slaves/forward.ista.ma";
	masters { 10.10.10.1; };
	allow-notify { 10.10.10.1; };
}

zone "10.10.10.in-addr.arpa" IN {
	type slave;
	file "/var/named/slaves/reverse.ista";
	masters { 10.10.10.1; };
	allow-notify { 10.10.10.1; };
}

setenforce 0
systemctl stop firewalld

cat /var/named/slaves/forward.ista.ma