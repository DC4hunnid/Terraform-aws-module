resource "aws_network_acl" "servicequik-public-acl" {
  vpc_id = var.vpc_id
  subnet_ids = var.public_subnet_id
  egress {
    protocol   = "-1" //-1 denotes to all protocol
    rule_no    = 200
    action     = "allow"
    cidr_block = var.pub_nacl_egress_cidr_block
    from_port  = 0 //opens all port from 0 to 0
    to_port    = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.pub_nacl_ingress_cidr_block
    from_port  = 0
    to_port    = 0
   }

  tags = {
    Name = "${var.vpc_name}-pub-nacl"
  }
}

resource "aws_network_acl" "servicequik-private-acl" {
  vpc_id = var.vpc_id
  subnet_ids = var.private_subnet_id
  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = var.pri_nacl_egress_cidr_block
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.pri_nacl_ingress_cidr_block
    from_port  = 0
    to_port    = 0
   }

  tags = {
    Name = "${var.vpc_name}-pri-nacl"
  }
}

