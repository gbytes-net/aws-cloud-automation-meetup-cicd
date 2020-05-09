resource "aws_eip" "nat-elastic-ip" {
  vpc = true

  depends_on = [aws_internet_gateway.template-internet-gateway]
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.nat-elastic-ip.id
  subnet_id = aws_subnet.template-public.id

  tags = {
    Name = "${var.project}-nat-gw"
    Project = var.project
  }
}

# add a route for traffic to the internet through the NAT gateway
# this way our private subnet can access the internet
resource "aws_default_route_table" "default-route-table" {
  default_route_table_id = aws_vpc.template-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "${var.project}-main-route-table"
    Project = var.project
  }
}