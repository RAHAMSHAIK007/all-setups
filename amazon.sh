#! /bin/bash
yum install httpd git -y
systemctl start httpd
systemctl status httpd
cd /var/www/html
git clone https://github.com/Ironhack-Archive/online-clone-amazon.git
mv online-clone-amazon/* .
tail -100f /var/log/httpd/access_log
