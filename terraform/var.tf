variable "region"{
  default = "ap-south-1"
}

variable "vpcname"{
  default= "hello"
}

variable "vpc_cidr"{
  default = "190.160.0.0/16"
}

variable "subnet_cidr"{
  type = "list"
  default = ["190.160.1.0/24","190.160.2.0/24"]
}
# declare the data soucrce
data "aws_availability_zones" "azs" {}
