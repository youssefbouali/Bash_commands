#Primaire : 1<P<4

#Etendu : 1<E<128



#Le partitionnement : fractionnement d'un support physique en plusieurs parties virtuelles, partition, destinées à accueillier un systeme de fichier

#Types de partitions : principales , étendue



#L'espace de swap dans Linux est utilisé lorsque la mémoire physique (RAM) est pleine



#Système de Fichier : est la façon dont le système d'exploitation structure les données sur le support physique



#SATA sda sdb sdc sdd
#IDE hda hdb hdc hdd



#Point de montage : Répertoire que sera monter sur la partition





#Etapes de partitionnement et de montage d'un disque physique :

 

#1- Partitionner le disque
#2- Formater les partitions 
#3- Montage






#Ajouter un nouveau disque sur VMware 30Go
sdb
fdiks -l : lister les partitions

fdisk /dev/sdb2

#taille formater créer dossier monter
menu n 

t
	L
8e

w

fdisk - l  /dev/sda : lister les partitions du disc sda

fdisk /dev/sda3 : sélectionner un disque



mkfs.ext4 /dev/sda3 : formater la partition sda3

mkdir /mnt/donnees : créer un répertoire

mount /dev/sda3 /mnt/donnees : montage






#read info : 
tune2fs -l /dev/sda1