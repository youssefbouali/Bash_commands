setenforce 0

nano /root/openstack answer.txt

CONFIG_HEAT_INSTALL=y
CONFIG_PROVISION_DEMO=n
CONFIG_KEYSTONE_ADMIN_
USERNAME=admin
CONFIG_KEYSTONE_ADMIN_PW=P@ssw0rd123
CONFIG_NEUTRON_OVN_BRIDGE_IFACES=br
ex:enp0s3

packstack answer file /root/openstack answer.txt

packstack allinone


ip a s enp0s3

ip a s br ex

ovs vsctl show