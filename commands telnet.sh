yum install telnet telnet-server
yum install xinetd
systemctl start telnet.socket
telnet 1.1.1.1