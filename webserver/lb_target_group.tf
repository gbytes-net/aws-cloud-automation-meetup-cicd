resource "aws_lb_target_group" "this" {
  name = replace(var.application_name, "/[^a-zA-Z0-9 -]/", "")
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  tags = {
    Application = var.application_name
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group_attachment" "instance-1-tg-attach" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id = aws_instance.public1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "instance-2-tg-attach" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id = aws_instance.public2.id
  port = 80
}