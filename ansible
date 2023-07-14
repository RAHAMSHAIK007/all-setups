SETUP:
Create 5 servers (1=ansible 2=dev 2=test)
Connect all servers to mobaxterm

ALL SERVERS:
sudo -i
1. hostnamectl set-hostname ansible/dev-1/dev-2/test-1/test-2
sudo -i

2. passwd root
3. vim /etc/ssh/sshd_config (uncomment: 38 , no=yes: 63)
4. systemctl restart sshd
5. systemctl status sshd

ANSIBLE SERVER:
amazon-linux-extras install ansible2 -y
yum install python python-pip python-dlevel -y
vim /etc/ansible/hosts   (inventory file)  (below: 12 th line)

[dev]
172.31.81.244
172.31.93.180

[test]
172.31.91.255
172.31.93.101

vim /etc/ansible/ansible.cfg (uncomment 14, 22)

ssh-keygen  -- > enter 4 times
ssh-copy-id root@private_ip of dev-1 -- > yes -- > password 
ssh private_ip of dev-1
ctrl + d

ssh-copy-id root@private_ip of dev-2 -- > yes -- > password 
ssh private_ip of dev-2
ctrl + d

ssh-copy-id root@private_ip of test-1 -- > yes -- > password 
ssh private_ip of test-1
ctrl + d

ssh-copy-id root@private_ip of test-2 -- > yes -- > password 
ssh private_ip of test-2
ctrl + d
