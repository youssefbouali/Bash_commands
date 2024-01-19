#Client : MUA : Message User Agent
#-> SMTP
#Server : MTA : Message Transfer Agent
#
#Imap - Pop3
#Client
#
#
#
#
#
#Sendmail
#Exim4
#Postfix
#
#
#
#Authontification
#SPF
#
#DNS
#list IP Addresses
#
#TXT @ v=spf1 a mx include:_spf.google.com ~all
#
#
#
#----------------------------
#https://netcorecloud.com/tutorials/install-centos-postfix/
#https://techsbucket.com/how-to-install-postfix-in-centos-7/

sudo yum install postfix


nano /etc/postfix/main.cf


myhostname = smtp.example.local
mydomain = example.local
myorigin = $mydomain
inet_interfaces = all
inet_protocols = all
mydestination = $myhostname, localhost.$mydomain, localhost,
mynetworks = 192.168.1.0/24, 127.0.0.0/8
home_mailbox = Maildir/


nano /etc/postfix/master.cf
smtp
submission
-o smtp_tls
-o smtp_sasl


systemctl enable postfix

systemctl restart postfix


useradd postfixtester

passwd postfixtester


	mail -s “Local Outbound SMTP Test” test@example.com < /dev/null

echo "Message" | mail -s "Essai Postfix" user1@web.ista.ma


ls /home/postfixtester/Maildir/new/

cat /home/postfixtester/Maildir/new/1336588056.Vfe01I786e3e7M938078.smtp.example.local

tailf /var/log/maillog












#------------IMAP--------------------------------
yum install dovecot 

/etc/dovecot.conf

protocols = imap imaps pop3 pop3s
mail_location = maildir:~/Maildir
pop3_uidl_format = %08Xu%08Xv
# Required on x86_64 kernels
login_process_size = 64


mkdir /home/john/Maildir
chown john:john /home/john/Maildir
chmod -R 700 /home/john/Maildir 


/etc/aliases


# Person who should get root's mail
root:           john
# User aliases
jsmith:         john
j.smith:        john


chkconfig --level 345 dovecot on
/etc/init.d/dovecot start
















#---------------------------------


yum -y install exim

nano /etc/exim/exim.conf


alternatives --set mta /usr/sbin/sendmail.exim


exim -C /etc/exim/exim.conf -bV


systemctl start exim 
systemctl enable exim


yum -y install dovecot



nano /etc/dovecot/conf.d/10-auth.conf


disable_plaintext_auth=no 
auth_mechanisms = plain login


nano /etc/dovecot/conf.d/10-mail.conf


mail_location = maildir:~/Maildir


nano /etc/dovecot/conf.d/10-master.conf

service auth { 
#...
#...     
    unix_listener auth-client {         
    mode = 0660         
    user = exim     
    } 
#... 
#...
}

systemctl start dovecot
systemctl enable dovecot



adduser -g exim -s /usr/sbin/nologin server
passwd server


userdel -r server


#--------------------------------
















#Vérifier que exim4 est bien installé sur votre serveur apt-get installexim
#Lancer l'assistant de configuration dpkg-reconfigure exim4-config
#Type d'installation: Envoi par relais («smarthost») -pas de courrier local. Le serveur doit juste envoyer des emails au serveur Relai. Il en gère pas Nom de courrier du système: core.isga.local
#Liste d'adress
#es IP où Exinsera en attente de connexions SMTP entrantes: 127.0.0.1:1.
#Autres destinations doPour les mêmes raisons que l'option précédente, il n
#Nom de domaine visible pour les utilisateurs locaux: core.isga.local. Peu Nom réseau ou adresse IP du système «smarthost»: smtp.gmail.com::587. C'es
#Faut-il minimiser les requêtes DNS (connexions à la demande) ? Non.
#Faut-il séparer la configuration dans plusieurs fichiers : Non.
#Vérifier les options générées par l'assistant: nano /etc/exim4/update-e
#Redémarrer le service exim4
#Envoyer un mail: - mal -s «Test" abderrahim.hilali@isga.ma
#Vérifier le log tail/var/log/exim4/mainlog
#Authentification auprès du relai
#Ajouter la ligne dans le fichier /etc/exim4/passwd.client: smtp@iga-fes Redémarrer le service exim4
#Renvoyer un mail à votre adresse personnelle
#Vérifier le log
#Vérifier la réception du mail





#1.
#2. Connecter serveur SMTP à internet
#3. Vérifier est ce que exim4 est bien installé sur votre serveur a. apt-get install exim4-base
#4. Lancer l'assistant de configuration
#a. dpkg-reconfigure exim4-config
#5. Choisir le Type d'installation: Envoi par relais («< smarthost >>) - pas d
#6. Vérifier les options générées par l'assistant: a. nano /etc/exim4/update-exim4.conf.conf
#7. Envoyer un mail de test a. mail-s "Test" abderrahim.hilali@isga.ma
#8. Vérifier le log
#a. tail /var/log/exim4/mainlog
#9. Ajouter la ligne dans le fichier /etc/exim4/passwd.client : : a. :smtp@iga-fes.ma: SMTP2018
#10. Redémarrer le service exim4.
#11. Renvoyer un mail à votre adresse personnelle.
#12. Vérifier le log.
#13. Vérifier la réception du mail sur ta boite mail personnelle.
#14. Modifier la configuration de votre serveur SMTP afin d'être utilisé par