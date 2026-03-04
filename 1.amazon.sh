#! /bin/bash
sudo -i
apt update
apt install apache2  git -y
git clone https://github.com/Ironhack-Archive/online-clone-amazon.git
mv online-clone-amazon/* /var/www/html/

