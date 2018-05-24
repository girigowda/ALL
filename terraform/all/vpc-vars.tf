# vpc variable

variable "region"{
  default = "ap-south-1"
}

variable "vpcname"{
  default= "hello"
}

variable "vpc_cidr"{
  default = "10.0.0.0/26"
}

# private subnets

variable "subnet1_cidr"{
  default = "10.0.0.0/28"
}

variable "AZ"{
  default = "ap-south-1a"
}

variable "subnet1_name"{
  default = "private_subnet"
}

# public subnets

variable "subnet2_cidr"{
  default = "10.0.0.16/28"
}

variable "AZ2"{
  default = "ap-south-1b"
}

variable "subnet2_name"{
  default = "public_subnet"
}


# create private route_table and associate route table

variable "route_table_name"{
  default = "private_route_table"
}

# create public route_table and associate

variable "route_table_name_2"{
  default = "public_route_table"
}

# create internet_gateway

variable "internet_gateway_name"{
  default = "My-gateway"
}

# create natgateway

variable "nat_gateway_name"{
  default = "my-nat"
}

# route table for public subnets

variable "route-for-public-subnet"{
  default = "0.0.0.0/0"
}

# route table for private subnets

variable "route-for-private-subnet"{
  default = "0.0.0.0/0"
}
