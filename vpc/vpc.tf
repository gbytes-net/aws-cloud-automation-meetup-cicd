resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "${var.application_name}-template-vpc"
    Application = var.application_name
  }
}