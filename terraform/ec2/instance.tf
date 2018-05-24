provider "aws" {
  access_key = "***********8888888"
  secret_key = "******************88"
  region     = "${var.AWS_REGION}"
}

resource "aws_instance" "example" {
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  security_groups = "${var.security}"
  key_name = "${var.key_name}"
}
