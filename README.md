# qpid-ansible
(some issue couldn't run by tag)
#fresh install
ansible-playbook -i hosts main.yaml

#run routers 
ansible-playbook -i hosts main.yaml --tags=run

#check status if qpid is running
ansible-playbook -i hosts main.yaml --tags=status
