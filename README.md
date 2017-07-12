# qpid-ansible
(some issue couldn't run by tag)
#fresh install
ansible-playbook -i hosts main.yaml

#only setup
ansible-playbook -i hosts main.yaml --tags=setup

#install client and router
ansible-playbook -i hosts main.yaml --tags=client,main


#run routers 
ansible-playbook -i hosts main.yaml --tags=run

#check status if qpid is running
ansible-playbook -i hosts main.yaml --tags=status
