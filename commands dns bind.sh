yum install bind
nano /etc/named.conf

zone "ista.ma" IN {
	type master;
	file "/var/named/forward.ista.ma";
}

zone "10.10.10.in-addr.arpa" IN {
	type master;
	file "/var/named/reverse.ista";
}

nano /var/named/forward.ista.ma
$TTL	604800
@	INSOA	ista.ma.	root.ista.ma.	(
			1
			684888
			68400
			2419200
			604800 )
@	IN	NS	dns1.ista.ma.
dns1	IN	A	10.10.10.2

nano /var/named/reverse.ista
$TTL	604800
@	INSOA	ista.ma.	root.ista.ma.	(
			1
			684888
			68400
			2419200
			604800 )
@	IN	NS	dns1.ista.ma.
2	IN	PTR	dns1.ista.ma.

systemctl restart named.service

nano /etc/resolv.conf
	nameserver 127.0.0.1

nslookup ftp.ista.ma