#!/bin/bash

source /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06/bin/demo-openrc.sh 

ip_server1=$(openstack stack output show stack IP_web_server1 -f value -c output_value)
echo "Vm1: $ip_server1"
ip_server2=$(openstack stack output show stack IP_web_server2 -f value -c output_value)
echo "Vm2: $ip_server2"
ip_server3=$(openstack stack output show stack IP_web_server3 -f value -c output_value)
echo "Vm3: $ip_server3"

openstack stack create -t load-balancer.yml --parameter "subnet_name=subnet1" --parameter "ip_server1=$ip_server1" --parameter "ip_server2=$ip_server2" --parameter "ip_server3=$ip_server3" lb
