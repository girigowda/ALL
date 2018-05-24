variable "AWS_REGION"{
   default = "ap-south-1"
}

variable "AMIS"{
  type = "map"
  default ={
    ap-south-1 = "ami-7c87d913"
  }
}

variable "security" {
  type = "list"
  default = ["my-security-group"]
}

variable "key_name"{
 default = "ubuntu"
}
