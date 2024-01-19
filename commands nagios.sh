#Supervision linux
apt install snmpd
nano /etc/snmp/snmpd.conf

#agentAddress udp:127.0.0.1:161
recommunity nagios-ro 1.1.1.1
systemctl restart snmpd



#Avant de procéder au téléchargement et installation installez les dépendances prérequis en utilisant les commandes suivante:

dnf install -y gcc glibc glibc-common perl httpd php wget gd gd-devel
dnf install openssl-devel
dnf update -y



#Avec une version linux-server on procède au téléchargement par les commandes suivantes:
useradd -m -p $(openssl passwd nagios) nagios 
#Cette commande crée l’utilisateur nagios sur le système et initie son mot de passe à nagios.

#Ensuite, on crée un dossier dans le répertoire personnel nagios nommé téléchargements 
mkdir /home/nagios/téléchargements

#On tape la commande suivante pour télécharger la dernière version nagios-4.4.7
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.7.tar.gz


#Par la suite on décompresse et on continu l’installation :
tar xzf nagioscore.tar.gz

cd nagioscore-nagios-4.4.7




#On compile via la commande: 
./configure
#Et enfin on tape: 
make all



make install-groups-users
#Cela ajoute les utilisateurs et les groupes s'ils n'existent pas



#L'utilisateur apache est également ajouté au groupe nagios.
Usermod –a –G nagios apache

#Et enfin 
make install



#Cela installe les fichiers de service ou de démon et les configure également pour démarrer au démarrage. Le service Apache httpd est également configuré à ce stade:

make install-daemoninit
systemctl enable httpd.service



#Ceci installe et configure le fichier de commande externe.
make install-commandmode

#Ceci installe les fichiers de configuration *SAMPLE*. Ceux-ci sont nécessaires car Nagios a besoin de certains fichiers de configuration pour lui permettre de démarrer.
make install-config

#Cela installe les fichiers de configuration du serveur Web Apache.
make install-webconf



#Pour accéder à l’interface d’administration de Nagios, il est nécessaire de configurer un accès Apache htaccess. Lancez la commande suivante :
htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin ofppt

#Cette commande crée le fichier htaccess dans l’arborescence du site d’administration (/usr/local/nagios/etc/htpasswd.users) et configure un premier utilisateur comme ci-dessous :
#login : nagiosadmin ;
#password : ofppt

#Dernières opérations : il faut redémarrer le service Apache et démarrer le service Nagios. Pour cela, lancez les commandes suivantes :
systemctl restart httpd
systemctl start nagios



#Pour accéder à l’interface d’administration de Nagios via l’interface web on tape
#http://<@IP_server>/nagios
#Username: nagiosadmin	
#Password: ofppt 






















#téléchargez les sources dans le répertoire/home/nagios/téléchargements avec les commandes suivantes :
cd /home/nagios/downloads
wget https://nagios-plugins.org/download/nagios-plugins-2.4.0.tar.gz
#Ou
Wget https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.0.tar.gz





#On décompresse le fichier télécharger avec la commande:
Tar zxf relase-2.4.0.tar.gz



#On se déplace vers le répertoire des plugins, on compile et on installe:
cd nagios-plugins-release-2.4.0/
./tools/setup
./configure
make
make install















#تثبيت التبعيات

yum install -y gcc glibc glibc-common gd gd-devel make httpd php perl openssl-devel

#postfix

#	net-snmp

#	يجب عليك إضافة مستخدم nagios إلى
#	النظام حتى تتجنب تشغيله كجذر:

# useradd nagios

#	ومجموعة nagcmd جديدة ستسمح بالخارج
#	أوامر يتم تشغيلها عبر واجهة الويب:

	# groupadd nagcmd
	# usermod -G nagcmd nagios
	# usermod -G nagcmd apache

cd /home/nagios

wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.11.tar.gz

#	wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.7.tar.gz

tar xzf nagioscore.tar.gz

cd nagioscore-nagios-4.4.11

#	الخطوة التالية هي تنزيل حزم التثبيت.
#	قم بإنشاء دليل جديد لتخزين التنزيل
#	المحتوى:

	# mkdir ~ / nagios
	# cd ~ / nagios

	mkdir /home/nagios/downloads

#	يمكنك استخدام wget لتنزيل الملفات:
	
	# wget http: //prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.7.tar.gz
	# wget http://nagios-plugins.org/download/na...
	
#	استخرج الملفات باستخدام Tar:
	
	# tar zxvf nagios-4.0.7.tar.gz
	# tar zxvf nagios-plugins-2.0.3.tar.gz
	
#	نحن الآن بحاجة إلى تجميع الملفات وتثبيتها
#	نذهب إلى دليل Nagios و
#	تشغيل برنامج التكوين

	# cd nagios-4.0.7
	# ./configure --with-command-group = nagcmd

#	بعد ذلك نحتاج إلى تجميع وتثبيت ملفات Nagios:

./configure

# make all

make install-groups-users
Usermod –a –G nagios apache

# make install

make install-daemoninit

systemctl enable httpd.service

make install-commandmode

make install-config

make install-webconf




#	$ sudo firewall-cmd --zone=public --add-port=80/tcp
	
#	$ sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
	
#	$ sudo firewall-cmd --reload





sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

	htpasswd -cb /usr/local/nagios/etc/htpasswd.users nagiosadmin ofppt



sudo systemctl restart httpd


#	وأخيرًا نحتاج إلى تثبيت نصوص الحرف الأول ،
#	الملفات المطلوبة لتشغيل Nagios من الأمر
#	خط وعينة ملفات التكوين
#	بالأوامر التالية:
	# make install-init
	# make install-commandmode
	# make install-config
#	الآن بعد أن قمنا بتثبيت Nagios وجاهز لـ
#	تشغيل نحتاج إلى تثبيت مكون الويب
#	عن طريق تشغيل الأمر التالي:

# make install-webconf

#	ونحتاج إلى إعداد كلمة المرور لـ
#	nagiosadmin المستخدم.
	
	# htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
	
#	أعد تشغيل apache حتى تصبح الإعدادات نافذة المفعول:

	# systemctl start httpd.service







#	حان الوقت لتثبيت مكونات Nagios الإضافية
#	تنفيذ الأوامر التالية:
	
	# cd ~ / nagios / nagios-plugins-2.0.3
	# ./configure --with-nagios-user = nagios --with-nagios-group = nagios


Wget https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.4.tar.gz

Tar zxf relase-2.4.4.tar.gz


yum install m4 gettext automake autoconf


cd nagios-plugins-release-2.4.0/
./tools/setup
./configure
make
make install


	# make
	# make install

#بعد ذلك علينا أن نجعل Nagios تبدأ في وقت التمهيد ،

# /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

#	إذا كان كل شيء على ما يرام ، أضف الخدمة للتشغيل عند التمهيد باستخدام هذه الأوامر:
	# chkconfig --add nagios
	# chkconfig --level 35 nagios on

#وابدأ الخدمة بالأمر التالي:

# systemctl start nagios.service

#افتح متصفح الويب:

#http: // Ip-Adddress / nagios

#اسم المستخدم: nagiosadmin
#كلمة المرور: كما هو محدد أعلاه



yum install epel-release
yum install nrpe
nano /etc/nagios/nrpe.cfg
allowed_hosts=127.0.0.1,::1,192.168.3.3


/usr/lib64/nagios/plugins/check_nrpe -H 127.0.0.1




cd /tmp 
wget -O nrpe.tar.gz https://github.com/NagiosEnterprises/nrpe/archive/nrpe-4.1.0.tar.gz 
tar xzf nrpe.tar.gz

cd /tmp/nrpe-nrpe-3.2.1/ 
./configure --enable-command-args 
make all 
make install-groups-users 
make install 
make install-config

echo >> /etc/services 
echo '# Nagios services' >> /etc/services 
echo 'nrpe    5666/tcp' >> /etc/services 
make install-init 
systemctl enable nrpe.service

systemctl start nrpe.service