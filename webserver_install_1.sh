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
wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py
wget https://s3.amazonaws.com/aws-codedeploy-us-east-1/cloudwatch/codedeploy_logs.conf
chmod +x ./awslogs-agent-setup.py
sudo python awslogs-agent-setup.py -n -r us-east-1 -c s3://aws-codedeploy-us-east-1/cloudwatch/awslogs.conf
sudo mkdir -p /var/awslogs/etc/config
sudo cp codedeploy_logs.conf /var/awslogs/etc/config/
sudo service awslogs restart


#
# install apache
sudo yum install httpd -y
sudo service httpd start
sudo chkconfig httpd on
echo "<h1>Instance</h1>" | sudo tee /var/www/html/index.html
