

resource "aws_instance" "public1" {
  ami = var.ami_id
  instance_type = "t2.micro"

  # this is optional, but needed if you want to ssh into your ec2 instance
  # here I have manually created a key pair in the console and I'm supplying the
  # name.
  #key_name = "ha_webserver"

  user_data = file(var.user_data_1)

  vpc_security_group_ids = [
    aws_security_group.this.id]

  subnet_id = aws_subnet.public1.id

  tags = {
    Name = "${var.project}-public-ec2-webserver"
    Project = var.project
  }
}