#!/bin/bash

source /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06/bin/demo-openrc.sh 

ip_lb=$(openstack stack output show lb ip_lb -f value -c output_value)
echo "ip_lb: $ip_lb"
ip_admin=$(openstack stack output show stack admin_sever_privateIP -f value -c output_value)
echo "ip_admin: $ip_admin"

openstack firewall group rule create --protocol tcp --destination-port 80 --destination-ip-address $ip_lb --action allow --name lb_rule
openstack firewall group rule create --protocol tcp --destination-port 2020 --destination-ip-address $ip_admin --action allow --name admin_rule
openstack firewall group rule create --protocol any --source-ip-address 10.1.1.0/24 --action allow --name int1_rule
openstack firewall group rule create --protocol any --source-ip-address 10.1.2.0/24 --action allow --name int2_rule

openstack firewall group policy create --firewall-rule "lb_rule" --firewall-rule "admin_rule" --firewall-rule "int1_rule" --firewall-rule "int2_rule" myfirewall


openstack firewall group create --ingress-firewall-policy myfirewall --no-port




