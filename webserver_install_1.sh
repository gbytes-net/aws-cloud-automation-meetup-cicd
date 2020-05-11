#!/bin/bash
sudo yum update -y

# install code deploy agent
sudo yum install ruby -y
sudo yum install wget -y
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status

# install apache
sudo yum install httpd -y
sudo service httpd start
sudo chkconfig httpd on
echo "<h1>Instance 1</h1>" | sudo tee /var/www/html/index.html