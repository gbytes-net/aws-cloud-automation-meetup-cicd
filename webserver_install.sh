#!/bin/bash
sudo yum update -y

#
# install code deploy agent
sudo yum install ruby -y
sudo yum install wget -y
cd /home/ec2-user
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent status

#
# install cloudwatch  logs agent
wget https://s3.amazonaws.com/aws-codedeploy-us-east-1/cloudwatch/codedeploy_logs.conf
sudo mkdir -p /var/awslogs/etc/config
sudo cp codedeploy_logs.conf /var/awslogs/etc/config/
sudo systemctl start awslogsd
sudo systemctl enable awslogsd.service

#
# install apache
sudo yum install httpd -y
sudo service httpd start
sudo chkconfig httpd on
