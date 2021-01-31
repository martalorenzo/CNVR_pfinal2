#!/bin/bash
sudo vnx -f /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06/openstack_lab.xml -P
DIR=$(pwd)
cd /mnt/tmp
/mnt/vnx/repo/cnvr/bin/get-openstack-tutorial.sh
cd openstack_lab-stein_4n_classic_ovs-v06
sudo vnx -f openstack_lab.xml -v --create
sudo vnx -f openstack_lab.xml -v -x start-all
sudo vnx -f openstack_lab.xml -v -x load-img
sudo vnx_config_nat ExtNet $(ip a | grep 138.4 | awk '{print $7}')

# Get demo privileges
source /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06/bin/demo-openrc.sh 

cd $DIR
openstack image create --disk-format qcow2 --container-format bare --file bbdd_server.qcow2 bd_server 
openstack image create --disk-format qcow2 --container-format bare --file web_server.qcow2 web_server


source /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06/bin/demo-openrc.sh 
openstack stack create -t scenario.yml -e parameters.yml stack


#openstack network create --share --external --provider-physical-network provider --provider-network-type flat ExtNet
#openstack subnet create --network ExtNet --gateway 10.0.10.1 --dns-nameserver 10.0.10.1 --subnet-range 10.0.10.0/24 --allocation-pool start=10.0.10.100,end=10.0.10.200 ExtSubNet
