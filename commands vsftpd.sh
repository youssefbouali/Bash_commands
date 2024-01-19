yum install vsftpd
systemctl enable vsftpd
systemctl start vsftpd
nano /etc/vsftpd/vsftpd.conf
ftpd_banner=Welcome
systemctl restart vsftpd
ftp://web.ista.ma

nano /etc/vsftpd/vsftpd.conf
	#anonymous_enable
	local_enable=YES
	write_enable=YES
	chroot_local_user=YES
	ftpd_banner=Tout accès non autorisé est interdit
	userlist_enable=YES

systemctl restart vsftpd
Echo 'BONJOUR userftp1 file1 ' > /home/userftp1/file1serveur
yum install lftp
lftp -u userftp1 192.168.10.5
get file1serveur
mget *serveur
put file1client