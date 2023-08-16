VER="2.3.3"
#TO GET NAGIOS PLUGINS:
curl -SL https://github.com/nagios-plugins/nagios-plugins/releases/download/release-$VER/nagios-plugins-$VER.tar.gz | tar -xzf -
cd nagios-plugins-2.3.3/
./configure
make install
#Create a nagiosadmin account for logging into the Nagios web interface. Note the password you need it while login to Nagios web console.
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
sudo service apache2 restart
sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
systemctl enable --now nagios
systemctl status nagios
~
