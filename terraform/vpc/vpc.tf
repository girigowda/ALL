provider "aws" {
  access_key = "*******************"
  secret_key = "*************"
  region     = "ap-south-1"
}

# create custome vpc

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/26"
  instance_tenancy = "default"

  tags {
    Name = "MyVPC"
  }
}

# create private subnets

resource "aws_subnet" "subnet-1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.0.0/28"
  availability_zone = "ap-south-1a"
  tags {
    Name = "private"
  }
}

# create public subnets2

resource "aws_subnet" "subnet-2" {
 vpc_id     = "${aws_vpc.main.id}"
 cidr_block = "10.0.0.16/28"
 availability_zone = "ap-south-1b"
  tags {
    Name = "public"
  }
}

# create private route_table and associate route table

resource "aws_route_table" "two" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "Route table private"
  }
}
resource "aws_route_table_association" "ab" {
  subnet_id      = "${aws_subnet.subnet-1.id}"
  route_table_id = "${aws_route_table.two.id}"
}

# create public route_table and associate

resource "aws_route_table" "one" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "Route table public"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.subnet-2.id}"
  route_table_id = "${aws_route_table.one.id}"
}

# create aws_internet_gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "pcx"
  }
}

# create Elastic ip

resource "aws_eip" "tuto_eip" {
  vpc      = true
}

# create aws_nat_gateway

resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.tuto_eip.id}"
  subnet_id     = "${aws_subnet.subnet-2.id}"

  tags {
    Name = "gw NAT"
  }
}

# aws_route

resource "aws_route" "r" {
  route_table_id            = "${aws_route_table.one.id}"
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.gw.id}"
}


resource "aws_route" "r1" {
  route_table_id            = "${aws_route_table.two.id}"
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.gw.id}"
}
