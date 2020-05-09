resource "aws_lb" "multi-instance-lb" {
  name               = "multi-instance-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.ec2-sg-web.id}"]
  subnets            = [aws_subnet.template-public.id, aws_subnet.template-public-2.id]

  enable_deletion_protection = false

  tags = {
    Project = var.project
  }
}
