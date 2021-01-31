# Se inicia el escenario
bash launch_scenario.sh

#Se crea el stack que lanza el balanceador de carga
#openstack stack create -t load-balancer.yml -e parameters2.yml lb
bash launch_lb.sh 
openstack stack show lb

#Se lanza el firewall
bash firewall.sh

#Para ejecutar algo en el terminal habilitan los permisos
source /mnt/tmp/openstack_lab-stein_4n_classic_ovs-v06/bin/demo-openrc.sh 







