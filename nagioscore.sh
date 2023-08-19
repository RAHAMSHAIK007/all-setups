#INSTALLING PREREQUISTES
apt install wget unzip vim curl gcc openssl build-essential libgd-dev libssl-dev libapache2-mod-php php-gd php apache2 -y

#INSTALL NAGIOS CORE:
export VER="4.4.6"
curl -SL https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-$VER/nagios-$VER.tar.gz | tar -xzf -
cd /root/nagios-4.4.6/

#TO COMPILE:

./configure

make all
make install-groups-users
usermod -a -G nagios nagios
make install
make install-init
make install-config
make install-commandmode
make install-webconf

a2enmod rewrite cgi
systemctl restart apache2

make install-exfoliation
make install-classicui
