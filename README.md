# qpid-ansible
(some issue couldn't run by tag)
#fresh install
	ansible-playbook -i hosts main.yaml

#Run only setup
	ansible-playbook -i hosts main.yaml --tags=setup

#Install client and router
	ansible-playbook -i hosts main.yaml --tags=client,router

## Install only router
	ansible-playbook -i hosts main.yaml --tags=router

## Run routers 
	ansible-playbook -i hosts main.yaml --tags=start

### Check status if qpid routers are running
	ansible-playbook -i hosts main.yaml --tags=status

##Test Setup
![alt text](https://github.com/aneeshkp/qpid-ansible/blob/master/utils/qpidprotonclientsetup.png)
### Running test client
(Check hosts file for details)
```
Central router ip :10.19.110.9 and 10.19.110.11
Event Sender: 10.19.110.15
Event Recevier: 10.19.110.17
Trafffic :10.19.110.1
          10.19.110.3
          10.19.110.21
          10.19.110.23

# cd 13nodes/source 
# make -f  proton,mk
####################### check utils folder for more stuff
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
