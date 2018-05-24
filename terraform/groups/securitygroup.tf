provider "aws" {
  access_key = "****************888"
  secret_key = "****************8888"
  region     = "ap-south-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "main"
  }
}
resource "aws_subnet" "subnet-1" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "subnet-1"
  }
}

resource "aws_security_group" "allow_all" {
  name        = "hello"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
   // prefix_list_ids = ["pl-12c4e678"]
  }
}

resource "aws_instance" "example" {
        ami = "ami-7c87d913"
        instance_type = "t2.micro"
        subnet_id = "${aws_subnet.subnet-1.id}"
        key_name = "ubuntu"
        security_groups = ["${aws_security_group.allow_all.id}"]
        tags{
                Name = "demo"
        }
}
