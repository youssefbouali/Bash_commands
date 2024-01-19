mkdir /partage-nfs
chmod 777 /partage-nfs
nano /etc/exports
/partage-nfs	*(rw)
systemctl start nfs

mkdir Desktop/nfsshare
chmod 777 Desktop/nfsshare
mount -t nfs 192.168.0.3:/partage-nfs Desktop/nfsshare