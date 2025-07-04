#! /bin/bash
sudo -i
apt update
apt install nginx  -y
cd /var/www/html/
git clone https://github.com/Ironhack-Archive/online-clone-amazon.git
mv online-clone-amazon/* .
