variable "vpc_name" {}

variable "vpc_security_group_ids" {}

variable "count_pub_ec2" {}

variable "count_pri_ec2" {}

//variable "pub_ami" {}

//variable "pri_ami" {}

variable "instance_type" {}

variable "tenancy" {}

variable "key_name" {}

variable "public_subnet_id" {}

variable "private_subnet_id" {}

variable "availability_zones_ec2" {}

//data source aws_ami for public instance

variable "most_recent_pub_instance" {}

variable "name_values_pub_instance" {}

variable "virtualization_type_values_pub_instance" {}

variable "owners_pub_instance" {}

//data source aws_ami for private instance

variable "most_recent_pri_instance" {}

variable "name_values_pri_instance" {}

variable "virtualization_type_values_pri_instance" {}

variable "owners_pri_instance" {}
