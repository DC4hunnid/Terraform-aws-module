variable "vpc_name" {
  default = "servicequik"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_id" {}

#variable "public_cidr" {}

#variable "private_cidr" {}

#variable "public_subnet_id" {}

#variable "private_subnet_id" {}

variable "eip_id" {}

variable "gateway_id" {}

variable "public_rt_id" {}

variable "private_rt_id" {}

variable "availibility_zone" {}
