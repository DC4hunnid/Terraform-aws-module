resource "aws_security_group" "servicequik-sg" {
  vpc_id = var.vpc_id
  
  //all inbound traffic
  ingress {
    from_port   = "22" //opens tcp 22 port for ssh
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = var.trusted_ip_ingress
  }

  // https
  ingress {
    from_port   = "443" //opens tcp port 443 for https request
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = var.trusted_ip_ingress
  }
  ingress {
    from_port   = "8834" //opens tcp port 8834 for nessus
    to_port     = "8834"
    protocol    = "tcp"
    cidr_blocks = var.trusted_ip_ingress
  }

  //all traffic 
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = var.trusted_ip_ingress_all_traffic
  }

  //all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.trusted_ip_egress
  }
  tags = {
    Name = "${var.vpc_name}-sg"
  }
}


