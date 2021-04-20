//Region
variable "region" {
  default = "ap-south-1"
}

//VPC

variable "vpc_name" {
  default = "main"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}



//Public Subnet

variable "count_pub_subnet" {
  default = 3
}

variable "pub_subnet_cidr_block" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}



//Private Subnet

variable "count_pri_subnet" {
  default = 3
}

variable "pri_subnet_cidr_block" {
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}



//Availability Zones for Subnet

variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}



//Public Route Table Association

variable "count_aso_pub_rt" {
  default = 3
}



//Private Route Table Association

variable "count_aso_pri_rt" {
  default = 3
}



//Network ACL

variable "pub_nacl_egress_cidr_block" {
  default = "0.0.0.0/0"
}

variable "pub_nacl_ingress_cidr_block" {
  default = "0.0.0.0/0"
}

variable "pri_nacl_egress_cidr_block" {
  default = "0.0.0.0/0"
}

variable "pri_nacl_ingress_cidr_block" {
  default = "0.0.0.0/0"
}



//Security Group

variable "trusted_ip_ingress" {
  default = ["0.0.0.0/0"]
}

variable "trusted_ip_ingress_all_traffic" {
  default = ["0.0.0.0/0"]
}

variable "trusted_ip_egress" {
  default = ["0.0.0.0/0"]
}



//Instance

variable "key_name" {
  default = "ubuntu"
}

variable "count_pub_ec2" {
  default = 2
}

variable "count_pri_ec2" {
  default = 2
}

//variable "pub_ami" {
  //default = "ami-0b84c6433cdbe5c3e"
//}

//variable "pri_ami" {
  //default = "ami-0b84c6433cdbe5c3e"
//}

variable "instance_type" {
  default = "t2.micro"
}

variable "tenancy" {
  default = "default"
}

variable "availability_zones_ec2" {
  default = ["ap-south-1a", "ap-south-1b"]
}


//data source aws_ami for public instance

variable "most_recent_pub_instance" {
  default = true
}

variable "name_values_pub_instance" {
  default = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}

variable "virtualization_type_values_pub_instance" {
  default = ["hvm"]
}

variable "owners_pub_instance" {
  default = ["099720109477"]
}


//data source aws_ami for private instance

variable "most_recent_pri_instance" {
  default = true
}

variable "name_values_pri_instance" {
  default = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}

variable "virtualization_type_values_pri_instance" {
  default = ["hvm"]
}

variable "owners_pri_instance" {
  default = ["099720109477"]
}


//VPC peering

variable "peer_region" {
  default = "ap-south-1"
}

variable "vpc_accepter_id" {
  default = "vpc-3649485e"
}

variable "vpc_peering_accepter_cidr_block" {
  default = "172.31.0.0/16"
}


//VPC accepter route table

variable "vpc_accepter_route_table_id" {
  default = "rtb-56de193d"
}

variable "vpc_peering_requester_destination_cidr_block" {
  default = "10.0.0.0/16"
}
