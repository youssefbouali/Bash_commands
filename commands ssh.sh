yum install openssh
systemctl enable sshd
nano /etc/ssh/ssh_config
	Port 22
	ListenAddress 192.168.0.3
	PermiRootLogin yes
systemctl restar sshd

ssh centos@192.168.0.3