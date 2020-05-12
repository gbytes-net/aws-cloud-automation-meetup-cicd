resource "aws_instance" "public1" {
  ami = var.ami_id
  instance_type = "t2.micro"

  # this is optional, but needed if you want to ssh into your ec2 instance
  # here I have manually created a key pair in the console and I'm supplying the
  # name.
  key_name = "ha_webserver"

  user_data = file("${path.module}/webserver_install.sh")

  vpc_security_group_ids = [
    aws_security_group.this.id]

  subnet_id = var.public_subnet1_id

  iam_instance_profile = aws_iam_instance_profile.this.id

  tags = {
    Name = var.application_name
    Application = var.application_name
  }
}