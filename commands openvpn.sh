#configure openvpn centos 7
#https://neoserver.site/help/installing-and-configuring-openvpn-server-running-centos-7

#https://www.digitalocean.com/community/tutorials/how-to-set-up-and-configure-an-openvpn-server-on-centos-7


sudo yum install epel-release -y


sudo yum install -y openvpn


wget -O /tmp/easyrsa https://github.com/OpenVPN/easy-rsa-old/archive/2.3.3.tar.gz


tar xfz /tmp/easyrsa

sudo mkdir /etc/openvpn/easy-rsa

sudo cp -rf easy-rsa-old-2.3.3/easy-rsa/2.0/* /etc/openvpn/easy-rsa

sudo chown centos /etc/openvpn/easy-rsa/

sudo cp /usr/share/doc/openvpn-2.4.4/sample/sample-config-files/server.conf /etc/openvpn


sudo nano /etc/openvpn/server.conf

push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
user nobody
group nobody
topology subnet
remote-cert-eku "TLS Web Client Authentication"
;tls-auth ta.key 0
tls-crypt myvpn.tlsauth


sudo openvpn --genkey --secret /etc/openvpn/myvpn.tlsauth

sudo mkdir /etc/openvpn/easy-rsa/keys

sudo nano /etc/openvpn/easy-rsa/vars
export KEY_COUNTRY="US"
export KEY_PROVINCE="NY"
export KEY_CITY="New York"
export KEY_ORG="DigitalOcean"
export KEY_EMAIL="sammy@example.com"
export KEY_EMAIL=sammy@example.com
export KEY_CN=openvpn.example.com
export KEY_NAME="server"
export KEY_OU="Community"

cd /etc/openvpn/easy-rsa
source ./vars

./clean-all

./build-ca

./build-key-server server

./build-dh

cd /etc/openvpn/easy-rsa/keys
sudo cp dh2048.pem ca.crt server.crt server.key /etc/openvpn

cd /etc/openvpn/easy-rsa
./build-key client

cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf


sudo nano /etc/sysctl.conf
net.ipv4.ip_forward = 1

sudo systemctl restart network.service

sudo systemctl -f enable openvpn@server.service

sudo systemctl start openvpn@server.service






#------------------------------

sudo yum install epel-release -y

yum install -y openvpn


yum install -y wget


wget https://github.com/OpenVPN/easy-rsa/archive/v3.0.8.tar.gz


tar -xf v3.0.8.tar.gz


cd /etc/openvpn/

mkdir /etc/openvpn/easy-rsa

mv /root/easy-rsa-3.0.8 /etc/openvpn/easy-rsa

cp /usr/share/doc/openvpn-2.4.9/sample/sample-config-files/server.conf /etc/openvpn

find / -name server.conf


vi /etc/openvpn/server.conf
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
user nobody
group nobody
topology subnet
remote-cert-eku "TLS Web Client Authentication"
;tls-auth ta.key 0
tls-crypt myvpn.tlsauth




tls-crypt myvpn.tlsauth

openvpn --genkey --secret /etc/openvpn/myvpn.tlsauth

	cd /etc/openvpn/easy-rsa/easyrsa3


sudo mkdir /etc/openvpn/easy-rsa/keys


sudo nano /etc/openvpn/easy-rsa/vars

export KEY_COUNTRY="US"
export KEY_PROVINCE="NY"
export KEY_CITY="New York"
export KEY_ORG="DigitalOcean"
export KEY_EMAIL="sammy@example.com"
export KEY_EMAIL=sammy@example.com
export KEY_CN=openvpn.example.com
export KEY_NAME="server"
export KEY_OU="Community"

cd /etc/openvpn/easy-rsa
source ./vars

./clean-all

./build-ca

./build-key-server server

./build-dh

cd /etc/openvpn/easy-rsa/keys
sudo cp dh2048.pem ca.crt server.crt server.key /etc/openvpn

cd /etc/openvpn/easy-rsa
./build-key client

cp /etc/openvpn/easy-rsa/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/openssl.cnf


systemctl -f start openvpn@server.service



/etc/openvpn/easy-rsa/keys/ca.crt/etc/openvpn/easy-rsa/keys/client.crt
/etc/openvpn/easy-rsa/keys/client.key
/etc/openvpn/ta.key


tls-auth ta.key 0






yum install iptables-services -y
systemctl mask firewalld
systemctl stop firewalld
systemctl enable iptables
systemctl start iptables
iptables --flush

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables




cp /etc/openvpn/easy-rsa/keys/ca.crt /etc/openvpn/easy-rsa/keys/client.crt /etc/openvpn/easy-rsa/keys/client.key /etc/openvpn/ta.key /etc/openvpn/myvpn.tlsauth /home/centos/Documents/


tls-auth /home/centos/Documents/ta.key 0

	sudo nano client.ovpn
	client
	tls-client
	ca /home/centos/Documents/ca.crt
	cert /home/centos/Documents/client.crt
	key /home/centos/Documents/client.key
	tls-crypt /home/centos/Documents/myvpn.tlsauth
	remote-cert-eku "TLS Web Client Authentication"
	proto udp
	remote 192.168.3.3 1194 udp
	dev tun
	topology subnet
	pull
	user nobody
	group nobody

sudo openvpn --config /home/centos/Documents/client.ovpn



client
dev tun
proto udp
remote 192.168.3.3 1194
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
ca /home/centos/Documents/ca.crt
cert /home/centos/Documents/client.crt
key /home/centos/Documents/client.key
tls-crypt /home/centos/Documents/myvpn.tlsauth


chmod 777 *

	sudo nano /etc/openvpn/client.conf
	client
	tls-client
	ca /home/centos/Documents/ca.crt
	cert /home/centos/Documents/client.crt
	key /home/centos/Documents/client.key
	tls-crypt /home/centos/Documents/myvpn.tlsauth
	remote-cert-eku "TLS Web Client Authentication"
	proto udp
	remote 192.168.3.3 1194 udp
	dev tun
	topology subnet
	pull
	user nobody
	group nobody


systemctl -f start openvpn@client.service



#---------------------





wget https://raw.githubusercontent.com/Angristan/openvpn-install/master/openvpn-install.sh -O centos7-vpn.sh


chmod +x centos7-vpn.sh


vi centos7-vpn.sh

sudo ./centos7-vpn.sh