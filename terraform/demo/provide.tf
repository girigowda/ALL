provider "aws" {
  access_key = "************************"
  secret_key = "************88"
  region     = "${var.region}"
}

# create custome vpc

resource "aws_vpc" "main" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags {
    Name = "${var.vpcname}"
  }
}

# create private subnets

resource "aws_subnet" "subnet-1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "${var.subnet1_cidr}"
  availability_zone = "${var.AZ}"
  tags {
    Name = "${var.subnet1_name}"
  }
}

# create public subnets2

resource "aws_subnet" "subnet-2" {
 vpc_id     = "${aws_vpc.main.id}"
 cidr_block = "${var.subnet2_cidr}"
 availability_zone = "${var.AZ2}"
  tags {
    Name = "${var.subnet2_name}"
  }
}

# create private route_table and associate route table

resource "aws_route_table" "two" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.route_table_name}"
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
    Name = "${var.route_table_name_2}"
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
    Name = "${var.internet_gateway_name}"
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
    Name = "${var.nat_gateway_name}"
  }
}

# aws_route

resource "aws_route" "r" {
  route_table_id            = "${aws_route_table.one.id}"
  destination_cidr_block    = "${var.route-for-public-subnet}"
  gateway_id = "${aws_internet_gateway.gw.id}"
}


resource "aws_route" "r1" {
  route_table_id            = "${aws_route_table.two.id}"
  destination_cidr_block    = "${var.route-for-private-subnet}"
  nat_gateway_id = "${aws_nat_gateway.gw.id}"
}
