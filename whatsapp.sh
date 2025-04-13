#! /bin/bash
yum install httpd git -y
systemctl start httpd
systemctl status httpd
chkconfig httpd on
cd /var/www/html
git clone  https://github.com/hamsahmedansari/axiom-whatsapp-ui-homePage.git
mv axiom-whatsapp-ui-homePage/* .
tail -100f /var/log/httpd/access_log
