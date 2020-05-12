resource "aws_lb" "this" {
  # name must be alphanumberic
  name               = replace(var.application_name,"/[^a-zA-Z0-9 -]/", "")
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = [var.public_subnet1_id, var.public_subnet2_id]

  enable_deletion_protection = false

  tags = {
    Application = var.application_name
  }
}