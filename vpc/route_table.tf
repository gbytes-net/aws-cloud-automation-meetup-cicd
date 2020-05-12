resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id

  # default routes are created by implicitly, so we don't have to
  # specify them. example: 10.0.0.0/16(destination) --> local(target)

  # route all external traffic through the internet gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.application_name}-public-route-table"
    Application = var.application_name
  }
}