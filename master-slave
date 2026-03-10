
MASTER AND SLAVE:
it is used to distribute the builds.
it reduce the load on jenkins server.
communication blw master and slave is ssh.
Here we need to install agent (java).
SLAVE IS your instance.
slave can use any platform.
label = way of assigning work for slave.

TIP-:

SETUP:
#STEP-1 : Create a server and install  JAVA-1.8.0 maven
sudo apt update
sudo apt install -y wget gnupg
wget -qO - https://repos.azul.com/azul-repo.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/azul.gpg
echo "deb https://repos.azul.com/zulu/deb stable main" | sudo tee /etc/apt/sources.list.d/zulu.list
sudo apt update
sudo apt install -y zulu8-jdk
sudo apt install -y maven


sudo apt install -y openjdk-17-jdk
update-alternatives --config java
set java to version17

#STEP-2: SETUP THE SLAVE SERVER
Dashboard -- > Manage Jenkins -- > Nodes  -- > New node -- > nodename: abc -- > permanent agent -- > save 

CONFIGURATION OF SALVE:

Number of executors : 3 #Number of Parallel builds
Remote root directory : /tmp #The place where our output is stored on slave sever.
Labels : one #place the op in a particular slave
useage: last option
Launch method : last option 
Host: (your privte ip)
Credentials -- > add -- >jenkins -- > Kind : ssh username with privatekey -- > username: ec2-user 
privatekey : pemfile of server -- > save -- > 
Host Key Verification Strategy: last option

DASHBOARD -- > JOB -- > CONFIGURE -- > RESTRTICT WHERE THIS JOB RUN -- > LABEL: SLAVE1 -- > SAVE

BUILD FAILS -- > WHY -- > WE NEED TO INSTALL PACKAGES

TOMCAT:

WEBSITE: FRONTEND -- > DB IS OPT
WEBAPP: FRONTEND + BACKEND -- > DB IS MANDATORY

WEB APPLICATION SERVER/APPLICATION SERVER/APP SERVER = TOMCAT

ITS A WEB APPLICATION SERVER USED TO DEPLOY JAVA APPLICATIONS.
IT IS WRITTEN ON JAVA LANGUAGE.
AGENT: JAVA
PORT: 8080
WE CAN DEPLOY OUR ARTIFACTS.
ITS FREE AND OPENSOURCE.
Its Platform Independent.
YEAR: 1999 

war : tomcat/webapps
jar : tomcat/lib

ALTERNATIVES: NGINX, IIS, WEBSPHERE, JBOSS, GLASSFISH, WEBLOGIC

NOTE: USE SLAVE AS TOMCAT FOR TEMP
SETUP: CREATE A NEW SERVER
INSTALL JAVA: sudo apt install -y openjdk-17-jdk



STEP-1: DOWNLOAD TOMCAT (dlcdn.apache.org)
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.107/bin/apache-tomcat-9.0.108.tar.gz

STEP-2: EXTRACT THE FILES
tar -zxvf apache-tomcat-9.0.108.tar.gz

STEP-3: CONFIGURE USER, PASSWORD & ROLES
vim apache-tomcat-9.0.108/conf/tomcat-users.xml

 56   <role rolename="manager-gui"/>
 57   <role rolename="manager-script"/>
 58   <user username="tomcat" password="raham123" roles="manager-gui, manager-script"/>

STEP-4: DELETE LINE 21 AND 22
vim apache-tomcat-9.0.108/webapps/manager/META-INF/context.xml

STEP-5: STARTING TOMCAT
sh apache-tomcat-9.0.108/bin/startup.sh

CONNECTION:
COPY PUBLIC IP:8080 
manager apps -- > username: tomcat & password: raham123

SCRIPT:

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.107/bin/apache-tomcat-9.0.107.tar.gz
tar -zxvf apache-tomcat-9.0.107.tar.gz
sed -i '56  a\<role rolename="manager-gui"/>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '57  a\<role rolename="manager-script"/>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '58  a\<user username="tomcat" password="raham123" roles="manager-gui, manager-script"/>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '59  a\</tomcat-users>' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '56d' apache-tomcat-9.0.107/conf/tomcat-users.xml
sed -i '21d' apache-tomcat-9.0.107/webapps/manager/META-INF/context.xml
sed -i '22d'  apache-tomcat-9.0.107/webapps/manager/META-INF/context.xml
sh apache-tomcat-9.0.107/bin/startup.sh


DEPLOYING THE APP:
WORKSPACE IN JENKINS DASHBOARD
TARGET 
CLICK ON 
NETFLIX-1.2.2.war	

GO TO TOMCAT
CLICK ON WAR file to deploy - > CHOOSE FILE -- > UPLOAD NETFLIX WAR -- > DEPLOY 
