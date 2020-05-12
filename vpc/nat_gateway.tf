resource "aws_eip" "this" {
  vpc = true

  depends_on = [
    aws_internet_gateway.this]

  tags = {
    Application = var.application_name
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id = aws_subnet.public1.id

  tags = {
    Name = "${var.application_name}-nat-gw"
    Project = var.application_name
  }
}

# add a route for traffic to the internet through the NAT gateway
# this way our private subnet can access the internet
resource "aws_default_route_table" "default-route-table" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "${var.application_name}-main-route-table"
    Application = var.application_name
  }
}