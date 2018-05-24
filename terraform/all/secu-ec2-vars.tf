variable "ami"{
  default = "ami-7c87d913"
}

variable "instance-type"{
  default = "t2.micro"
}

variable "key-pair"{
  default = "ubuntu"
}

variable "instance-name-1"{
  default = "bastion"
}

variable "instance-name-2"{
  default = "private-EC2"
}

# security_groups variable

variable "group-name"{
  default = " bastion-group"
}

variable "description"{
  default = "Allow all inbound traffic"
}
