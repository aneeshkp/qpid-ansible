```Setup test environment as shown below.```

### Test Setup With single event producer and consumer and with 100*4  telemetry producers and 1 telemetry  consumer (100 nodes of telemetry sending messages to single local router)
![alt text](https://github.com/aneeshkp/qpid-ansible/blob/master/utils/qpidprotonclientsetupwithtelemetry2.png)

### Test Setup showing client for events only
![alt text](https://github.com/aneeshkp/qpid-ansible/blob/master/utils/qpidprotonclientsetup.png)
### Running test client
# qpid-ansible
~~(some issue couldn't run by tag)~~
~~#fresh install (not )~~
~~#	ansible-playbook -i hosts main.yaml~~
# READ FIRST
---
This script by default expects  to run the qdrouterd threads  on their own cores.
By default qdrouterd uses 5 threads total.  The formula is the number
of configured workerThreads (default 4) plus one (for the core
thread).
### In order to configure this, you need to.
---
 #un comment affinity_enabled: True in group_vars/all
 1. affinity_enabled: True
 1. Run ansible playbook with --tags=setup-grub (sets grub.conf isolcpus: 3,4,5,6,7 and reboots)
 systemd file is created with /usr/bin/taskset -a 0x00F8 (ps: roles/common/templates/qpid-router-service.j2 )
### If you do not run setup-grub then
---
 ~~~1. please remove this text "/usr/bin/taskset -a 0x00F8"  from "roles/common/templates/qpid-router-service.j2"~~~
 1. comment affinity_enabled: true
 #affinity_enabled: True
 

---
# Running playbook
~~~## Run only setup(if required only , sets up ssh and other stuff)~~~
~~~ansible-playbook -i hosts main.yaml --tags=setup~~~

## Install client and router on all nodes, two main centralized router will be installed on router nodes and local nodes on all client nodes (config tag will open firewall)
	ansible-playbook -i hosts main.yaml --tags=proton-client,router,config

## Install only router as central router and local router and configure
	ansible-playbook -i hosts main.yaml --tags=router,config

## Run routers
	ansible-playbook -i hosts main.yaml --tags=start

### Check status if qpid routers are running
	ansible-playbook -i hosts main.yaml --tags=status
(Check hosts file for details)
```
Central router ip :10.19.110.9 and 10.19.110.11
Event Sender: 10.19.110.15
Event Recevier: 10.19.110.17
Trafffic :10.19.110.1
          10.19.110.3
          10.19.110.21
          10.19.110.23

# ~~cd 13nodes/source~~
#cd proton-examples/latency
# make -f  proton,mk
####################### check 13nodes/utils folder for more stuff
#EVENT RECEVIER
./proton-receiver -t unicast/event -l -c -1  -a 10.19.110.17:5672


#EVENT SENDER
./proton-sender -t unicast/event -l -c -1 -S 1000 -m 10 -M 1000 -a 10.19.110.15:5672

#TRAFFIC RECEVEIR
./proton-receiver -t unicast/traffic -l -c -1  -a 10.19.110.25:5672


#For one instance
#TRAFFIC_SENDER One msg per sec
./proton-sender -t unicast/traffic -l -c -1 -s 1500 -S 1000 -m 1000 -M 1000 -a 10.19.110.15:5672

#For 100 instances
IP_ADDR=$(ip addr show | grep "inet " | grep 10.19.110.* |  grep -v "127.0.0.1" | awk '{print $2}' | cut -d '/' -f 1)
for i in {1..100};do
./proton-sender -t unicast/traffic -l -c -1 -S 1000 -m 100 -M 100 -a $IP_ADDR:5672 &
done


#100 instances of traffic - use tmux for multiple windows
#$tmux
#$sh tmux_traffic_send_all.sh
#$
IP_ADDR=$(ip addr show | grep "inet " | grep 10.19.110.* |  grep -v "127.0.0.1" | awk '{print $2}' | cut -d '/' -f 1)
for i in {1..100};do
./proton-sender -t unicast/traffic -l -c -1 -S 1000 -m 100 -M 100 -a $IP_ADDR:5672 &
done
```
