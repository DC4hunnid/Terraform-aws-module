##VPC##

resource "aws_vpc" "servicequik" {
  cidr_block = var.vpc_cidr
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  instance_tenancy = "default"
  tags = local.main_tags
}




##Public Subnet##

resource "aws_subnet" "servicequik-public-subnet" {
  count = 3
  vpc_id = var.vpc_id
  availability_zone = var.availability_zones[count.index]
  cidr_block = "10.0.${count.index+1}.0/24"
  map_public_ip_on_launch = "true"
 
  tags = {
    Name = "${var.vpc_name}-pub-subnet-${count.index+1}"
  }
}




##Private  Subnet##

resource "aws_subnet" "servicequik-private-subnet" {
  count = 3
  vpc_id = var.vpc_id
  availability_zone = var.availability_zones[count.index]
  cidr_block = "10.0.${count.index+4}.0/24"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "${var.vpc_name}-pri-subnet-${count.index+1}"
  }
}



##eip##

resource "aws_eip" "servicequik-eip" {
  count = 3
  vpc = true
  tags = local.eip_tags
}


##Internet Gateway##

resource "aws_internet_gateway" "servicequik-igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.vpc_name}-ig"
  }
}




##NAT Gateway##

resource "aws_nat_gateway" "servicequik-nat" {
  count = 3
  allocation_id = aws_eip.servicequik-eip.*.id[count.index]
  subnet_id = aws_subnet.servicequik-public-subnet.*.id[count.index]
  tags = {
    Name = "${var.vpc_name}-nat-${count.index+1}"
  }
}

##Public Route Table##

resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }
  tags = local.public_route_tags
}


resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id
  tags = local.private_route_tags
}





##Association Route Table##

resource "aws_route_table_association" "servicequik-aso-pub-rt"{
  count = 3
  subnet_id = aws_subnet.servicequik-public-subnet.*.id[count.index]
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "servicequik-aso-pri-rt"{
  count = 3
  subnet_id = aws_subnet.servicequik-private-subnet.*.id[count.index]
  route_table_id = aws_route_table.private-rt.id
}



##Network ACL##

resource "aws_network_acl" "servicequik-public-acl" {
  count = 3
  vpc_id = var.vpc_id
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "172.22.${count.index+1}.0/24"
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "172.22.${count.index+1}.0/24"
    from_port  = 80
    to_port    = 80
   }
}

resource "aws_network_acl" "servicequik-private-acl" {
  count = 3
  vpc_id = var.vpc_id
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "172.22.${count.index+4}.0/24"
    from_port  = 443
    to_port    = 443
  }
  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "172.22.${count.index+4}.0/24"
    from_port  = 80
    to_port    = 80
   }
}



##Security Group##

resource "aws_security_group" "servicequik-sg" {
  vpc_id = var.vpc_id
  egress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.vpc_name}-sg"
  }
}




##EC2 Instance##

resource "aws_instance" "servicequik-instance" {
  count = 3
  ami = var.ami
  instance_type = var.instance_type
  tenancy = var.tenancy
  subnet_id = aws_subnet.servicequik-public-subnet.*.id[count.index]
  availability_zone = var.availability_zones[count.index]
  #vpc_security_group_ids = var.security_group_id
  tags = {
    Name = "${var.vpc_name}-ec2-${count.index+1}"
  }
}
