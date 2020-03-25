#! /bin/bash
sudo apt update
sudo apt install openjdk-8-jdk nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
echo "Initial Jenkins Password: "
sudo cat /var/lib/jenkins/secrets/initialAdminPassword