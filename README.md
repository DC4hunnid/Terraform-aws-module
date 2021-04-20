# Create VPC, 3 public and private subnet in each availability zone, route table with internet gateway and nat gateway, network acl, security group and ec2 instance


## Shortcut tags

* pub = public
* pri = private
* count = count for resource
* aso = association
* nacl = Network ACL
* sg = Security Group

## Provide region specific details in variables.tf

* Change the region according to your requirement
```
variable "region" {
  default = "ap-south-1"
}
```

## Steps need to perform before execution

* Set the VPC Name and VPC Cidr in variables.tf
```
variable "vpc_name" {
  default = "main"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
```

## There are 3 public and 3 private subnet and default cidr are configured in the code

* Set the count and cidr block for the public and private subnet in variables.tf
```
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
```

## Default availability zones for subnet are configured in variables.tf

* Change the availability for subnet as per your requirements
```
variable "availability_zones" {
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
```

## The count for elastic IP, NAT Gateway, Private Route table, Public and private route table association are set 3 as a default

* Change the count for elastic IP, NAT Gateway, Private Route table, Public and private route table association as per your requirement
```
//Elastic IP

variable "count_eip" {
  default = 3
}



//NAT Gateway

variable "count_nat" {
  default = 3
}



//Public Route Table

variable "count_aso_pub_rt" {
  default = 3
}



//Private Route Table

variable "count_pri_rt" {
  default = 3
}



//Private Route Table Association

variable "count_aso_pri_rt" {
  default = 3
}
```

## Provide the ingress and egress cidr block for Network ACL

* Change the cidr block as per your requirement
```
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
```

## Provide the ingress and egress cidr block for Security Group

* Change the CIDR block as per youre requirement
```
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
```

## Provide the configurations for EC2 along with the public key

* CHange the setting as per your requirement (Instance with type t2.micro is not supported in availability zone ap-south-1c so the ec2 are created in the subnets that are in the availability zones ap-south-1a and ap-south-1b. You can change the instance type and also availability zones of ec2 to create ec2 in other subnets which are in availability zone ap-south-1c.

```
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
```
