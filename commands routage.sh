cd /etc/sysconfig/network-scripts
nano ifcfg-ens35

GATEWAY="192.168.2.2"

systemctm restart network


route add -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.2.2

route -n

route del -net 192.168.3.0/24 gw 192.168.2.2





ip route 192.168.3.0/24 192.168.2.2



cd /etc/sysconfig/network-scripts
nano ifcfg-ens33

GATEWAY="192.168.2.1"

systemctm restart network


route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.2.1

route -n

route del -net 192.168.1.0/24 gw 192.168.2.1





ip route 192.168.1.0/24 192.168.2.1




















#1- Configuration IP des machines (Client/Serveur)
#
#2- Ajouter l'adresse IP du gateway (Client)
#
#3- Ajouter une route statique (commande) : 
	
	 route add -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.2.1

#4- Supprimer une route statique (commande) : 
	
	 route del -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.2.1

#				(package : Quagga)
#***************************************************************************************
#Installer le package : quagga 
#Configurer le service du routage 
#	- Statique (zebra.conf)

	cp /usr/share/doc/quagga.0****/zebra.conf.sample /etc/quagga/zebra.conf #(ecraser l'ancien fichier o/n)
#	Modifier /etc/quagga/zebra.conf : 

	hostname Router1
	password ofppt
	enable password essaouira

#Redemarrer le service : systemctl restart zebra.service

#Accéder au serveur zebra avec la commande telnet (verifier si telnet est installé)
	 telnet localhost 2601 #(N° port du zebra)

#	Configuration avec les commande IOS CISCO

#		..... Ajouter une route statique : 
		ip route 192.168.3.0/24

#Afficher la table de routage avec la commande (show ip route)
#******************************************************************************************
#	- Dynamique (ripd.conf)
	cp /usr/share/doc/quagga.0****/ripd.conf.sample /etc/quagga/ripd.conf

#	Modifier /etc/quagga/ripd.conf : 

	hostname Router1
	password ofppt
	enable password essaouira

#Redemarrer le service : systemctl restart ripd.service

#Accéder au serveur ripd avec la commande telnet (verifier si telnet est installé)
	telnet localhost 2602 #(N° port du ripd)

#	Configuration avec les commande IOS CISCO





#******************************************************************************************
#Commandes configuration CISCO
#******************************************************************************************
Router>enable
Router#configure terminal
Router(config)# interface fastethernet 0/0
Router(config-if)# ip address 192.168.1.1 255.255.255.0
Router(config-if)# no shutdown
Router(config-if)# exit
Router(config)# interface fastethernet 0/0
Router(config-if)# ip address 192.168.2.1 255.255.255.0
Router(config-if)# no shutdown
Router(config-if)# exit
******* Router(config)# ip route 192.168.3.0 255.255.255.0 192.168.2.2 (Ajouter route manuellement)
******* Router(config)# router rip (Activer routage dynamique avec RIP)
Router(config-router)# version ???
Router(config-router)# network 192.168.1.0 (réseau voisin)
Router(config-router)# network 192.168.2.0
Router(config-router)# redistribute-connected (en cas de besoin)