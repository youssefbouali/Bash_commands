nano /etc/sysconfig/network-scripts/ifcfg-ens33
	BOOTPROTO=dhcp
nslookup web.ista.ma

yum install httpd
systemctl stop firewalld
systemctl enable httpd
systemctl start httpd
nano /var/www/html/index.html
https://labs.wsoum.ml/web_editor/code/ista

<html>
<head>
	<title>Welcome</title>
</head>

<body>
<h1>text</h1>
</body>
</html>




cd /etc/httpd/conf.d
nano site2.ma.conf

<VirtualHost *:80>
	ServerName www.site2.ma
	ServerAlias site2.ma
	DocumentRoot /var/www/site2.ma/public_html
	ErrorLog /var/www/site2.ma/error.log
	CustomLog /var/www/site2.ma/requests.log combined
</VirtualHost>

mkdir -p /var/www/site2.ma/public_html
chown -R apache:apcha /var/www/site2.ma/public_html
chmod -R 755 /var/www

setenforce 0
systemctl restart httpd

nano /etc/named.conf

zone "site2.ma" IN {
	type master;
	file "/var/named/site2.ma";
}

cd /var/named

nano site2.ma

$TTL 1D
@	IN	SOA	@ root.site2.ma	(

)
	NS	web.ista.ma.
www	CNAME	web.ista.ma.


nano /var/www/site2.ma/public_html/index.html
https://labs.wsoum.ml/web_editor/code/ista

<html>
<head>
	<title>Welcome Site2.ma</title>
</head>

<body>
<h1>text</h1>
</body>
</html>


apachectl configtest
httpd -t