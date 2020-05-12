resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = {
    Name = var.application_name
    Application = var.application_name
  }
}