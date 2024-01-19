iptables -I INPUT -p udp --destination-port 161 -j ACCEPT



#•	INPUT : contrôle les paquets entrants sur la machine ;
#•	FORWARD : filtre les paquets qui entrent sur la machine mais doivent être transférés ailleurs ;
#•	OUTPUT : contrôle les paquets sortant de la machine.

sudo iptables –t <type de tableau> <action> <direction> <conditions> -j #<ce qu'il faut faire>

#1.Éléments	Contenus	Descriptions
-t	--table	
#<Type de tableau>		Filtre par défaut



#<action>	-A: append	Ajouter une règle à la chaîne iptables
#	-D: delete	Supprimer la règle qui correspond
#	-L: list	Lister toutes les règles
#	-F: Flush	Supprimer toutes les règles
#	-P: policy	Modifier la stratégie par défaut
#
#<direction>	INPUT	Filtrage des paquets entrants
#	OUTPUT	Filtrage des paquets sortants
#	FORWARD	Filtrage des paquets entrants et à transférer


#<ce qu'il faut faire>	ACCEPT	Le paquet est accepté sur l'interface entrante
#	DROP	Le paquet est bloqué. Aucun message d'erreur n'est renvoyé
#	REJECT	Le paquet est bloqué. Un message d'erreur est renvoyé
#	LOG	Les informations sur le paquet sont envoyées au démon syslog pour la journalisation et iptables continue le traitement avec la règle suivante dans la table

#2.Éléments	Contenus	Descriptions



#<conditions>	-s <ip>	Spécifier une adresse IP source
#	-d <ip>	Spécifier une adresse IP destination
#	-i <eth>	Spécifier une interface d’entrée (Input)
#	-o <eth>	Spécifier une interface de sortie (Output)
#	-p <protocole> --dport <num>	Spécifier le port destination d’un protocole donné
#	-p <protocole> --sport <num>	Spécifier le port source d’un protocole donné








#3.Exemples de commandes iptables	Description
sudo iptables –A INPUT -p tcp -m tcp --dport 23 –j DROP	Bloque les connexions TCP entrantes au port 23
sudo iptables –A OUTPUT –p udp –m tcp --sport 53 –j DROP	Bloque les connexions UDP sortantes du port 53

sudo iptables –A INPUT –i eth0 –p tcp --dport 22 –m state --state NEW,
ESTABLISHED –j ACCEPT	
#Accepte les demandes d'établissement de nouvelles connexions et datagramme faisant partie d'une connexion déjà établie
sudo iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT	Accepte les echo-request (paquet icmp de type 8) sortantes
