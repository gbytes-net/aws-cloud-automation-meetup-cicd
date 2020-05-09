resource "aws_internet_gateway" "template-internet-gateway" {

  vpc_id = aws_vpc.template-vpc.id

  tags = {
    Name = "${var.project}-ig"
    Project = var.project
  }
}