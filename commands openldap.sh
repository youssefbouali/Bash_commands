openldap 

yum install compat-openldap openldap-servers-sql openldap-devel


netstat -antup | grep -i 389

nslookup srv1.ista.ma

root@centos~#: ldapsearch -x cn=userldap -b dc=ista,dc=ma
ldapsearch -x -D cn=userldap,dc=ista,dc=ma 


	t@centos~# ldapsearch -W -D "cn=service,dc=ista,dc=ma" "uid=userldap,ou=servicegroup,dc=ista,dc=ma"


t@centos~# ldapdelete -W -D "cn=service,dc=ista,dc=ma" "uid=userldap,ou=servicegroup,dc=ista,dc=ma"

ldappasswd -s mdpasse -W -D "cn=service,dc=ista,dc=ma" -x "uid=userldap,ou=servicegroup,dc=ista,dc=ma"

Pour tester la configuration du service taper la commande
root@centos~#: slaptest -u



yum install openldap-servers openldap-clients
systemctl enable slapd
systemctl start slapd


nano /etc/resolv.conf
slappasswd
#	:123456


nano ldaprootpasswd.ldif

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: {SSHA}PASSWORD_CREATED

ldapadd -Y EXTERNAL -H ldapi:/// -f ldaprootpasswd.ldif



cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

chown -R ldap:ldap /var/lib/ldap/DB_CONFIG



systemctl restart slapd


ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif


#//nano monitor.ldif
nano ldapdomain.ldif

dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read by dn.base="cn=service,dc=ista,dc=ma" read by * none

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=ista,dc=ma

dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=service,dc=ista,dc=ma

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcRootPW
olcRootPW: {SSHA}PASSWORD

dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcAccess
olcAccess: {0}to attrs=userPassword,shadowLastChange by
dn="cn=service,dc=ista,dc=ma" write by anonymous auth by self write by * none
olcAccess: {1}to dn.base="" by * read
olcAccess: {2}to * by dn="cn=service,dc=ista,dc=ma" write by * read

ldapmodify -Y EXTERNAL -H ldapi:/// -f ldapdomain.ldif


#//base.ldif
nano baseldapdomain.ldif

dn: dc=ista,dc=ma
objectClass: top
objectClass: dcObject
objectclass: organization
o: ista ma
dc: ista

dn: cn=service,dc=ista,dc=ma
objectClass: organizationalRole
cn: service
description: Service Account

dn: ou=service1,dc=ista,dc=ma
objectClass: organizationalUnit
ou: Account

dn: ou=servicegroup,dc=ista,dc=ma
objectClass: organizationalUnit
ou: Group

dn: ou=servicegroup1,dc=ista,dc=ma
objectClass: organizationalUnit
ou: Group

ldapadd -x -D cn=service,dc=ista,dc=ma -W -f baseldapdomain.ldif



nano ldapgroup.ldif

dn: cn=service,ou=servicegroup,dc=ista,dc=ma
objectClass: top
objectClass: posixGroup
gidNumber: 1005

ldapadd -x -W -D "cn=service,dc=ista,dc=ma" -f ldapgroup.ldif

useradd userldap
passwd userldap



nano ldapuser.ldif

dn: uid=userldap,ou=servicegroup,dc=ista,dc=ma
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: userldap
uid: userldap
uidNumber: 1005
gidNumber: 1005
homeDirectory: /home/userldap
userPassword: {SSHA}8me5NZZz1LfgLIfUTezj/01TKiBMZUux
loginShell: /bin/bash
gecos: userldap
shadowLastChange: 0
shadowMax: 0
shadowWarning: 0

ldapadd -x -D cn=service,dc=ista,dc=ma -W -f ldapuser.ldif

authconfig --enableldap --enableldapauth --ldapserver=srv1.ista.ma --ldapbasedn="dc=ista,dc=ma" --enablemkhomedir --update






#Pour tester la configuration du service taper la commande
root@centos~#: slaptest -u




yum install -y openldap-clients nss-pam-ldapd

authconfig --enableldap --enableldapauth --ldapserver=172.16.0.10                                       --ldapbasedn="dc=efp,dc=lan" --enablemkhomedir --update

systemctl restart nslcd

getent passwd userldap


#//server
nano /etc/exports
/home    *(rw,sync)

yum -y install rpcbind nfs-utils



mount –t nfs 172.16.0.10:/home   /home
su - userldap




















root@centos ~]# vim /etc/phpldapadmin/config.php
$servers->setValue('server','name','CentOS LDAP');
$servers->setValue('server','host','127.0.0.1');
$servers->setValue('server','port',389);
$servers->setValue('server','base',array('dc=centos,dc=com'));
$servers->setValue('login','attr','dn'); 
// $servers->setValue('login','attr','uid'); 
$servers->setValue('login','bind_id','cn=admin,dc=centos,dc=com');
$config->custom->appearance['hide_template_warning'] = true;