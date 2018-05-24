# creat security_groups

resource "aws_security_group" "allow_all" {
  name        = "${var.group-name}"
  description = "${var.description}"
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
  }
}

resource "aws_instance" "example" {
        ami = "${var.ami}"
        instance_type = "${var.instance-type}"
        # vpc_id     = "${aws_vpc.main.id}"
        subnet_id = "${aws_subnet.subnet-2.id}"
        key_name = "${var.key-pair}"
        security_groups = ["${aws_security_group.allow_all.id}"]
        tags{
                Name = "${var.instance-name-1}"
        }
}

resource "aws_instance" "example2" {
        ami = "${var.ami}"
        instance_type = "${var.instance-type}"
        # vpc_id     = "${aws_vpc.main.id}"
        subnet_id = "${aws_subnet.subnet-1.id}"
        key_name = "${var.key-pair}"
        security_groups = ["${aws_security_group.allow_all.id}"]
        tags{
                Name = "${var.instance-name-1}"
        }
}
