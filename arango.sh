echo 'deb https://download.arangodb.com/arangodb34/DEBIAN/ /' | sudo tee /etc/apt/sources.list.d/arangodb.list
wget -q https://download.arangodb.com/arangodb34/DEBIAN/Release.key -O- | sudo apt-key add -
sudo apt update -y
sudo apt -y install apt-transport-https
sudo apt -y install arangodb3
sudo systemctl start arangodb3
sudo systemctl status arangodb3
sudo arangosh
