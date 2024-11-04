# STEP-1: INSTALLING GIT, JAVA 17, AND MAVEN
yum install git java-openjdk17 maven -y

# STEP-2: GETTING THE REPO (jenkins.io --> download -- > redhat)
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# STEP-3: INSTALLING JENKINS
yum install jenkins -y

# STEP-4: SET JAVA ALTERNATIVES (optional, if you have multiple versions of Java installed)
update-alternatives --config java

# STEP-5: RESTARTING JENKINS (when we download service it will be in a stopped state)
systemctl start jenkins.service
systemctl status jenkins.service
