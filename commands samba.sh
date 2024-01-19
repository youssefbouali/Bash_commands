yum install samba
systemctl enable smb
nano /etc/samba/smb.conf
	workgroup = ista
useradd samba-1
smbpasswd -a samba-1
	: 123456
systemctl restart smb

Win+r
\\192.168.0.3
	samba-1 : 123456
	
cd /home/samba-1