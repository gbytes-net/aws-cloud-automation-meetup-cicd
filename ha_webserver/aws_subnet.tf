resource "aws_subnet" "template-public" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.template-vpc.id

  availability_zone = var.availability_zones[0]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-template-public"
    Project = var.project
  }
}

resource "aws_subnet" "template-public-2" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.template-vpc.id

  availability_zone = var.availability_zones[1]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-template-public-2"
    Project = var.project
  }
}

resource "aws_subnet" "template-private" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.template-vpc.id

  availability_zone = var.availability_zones[1]

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-template-private"
    Project = var.project
  }
}

resource "aws_subnet" "template-private-2" {
  cidr_block = "10.0.4.0/24"
  vpc_id = aws_vpc.template-vpc.id

  availability_zone = var.availability_zones[0]

  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-template-private-2"
    Project = var.project
  }
}



# we link our public route table to our public subnet
resource "aws_route_table_association" "public_route_table_association" {

  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.template-public.id
}


