//data source for public instance

data "aws_ami" "data_pub_instance" {
  most_recent = var.most_recent_pub_instance

  filter {
    name   = "name"
    values = var.name_values_pub_instance
  }

  filter {
    name   = "virtualization-type"
    values = var.virtualization_type_values_pub_instance
  }

  owners = var.owners_pub_instance
}



//data source for private instance

data "aws_ami" "data_pri_instance" {
  most_recent = var.most_recent_pri_instance

  filter {
    name   = "name"
    values = var.name_values_pri_instance
  }

  filter {
    name   = "virtualization-type"
    values = var.virtualization_type_values_pri_instance
  }

  owners = var.owners_pri_instance
}



//resource aws public instance

resource "aws_instance" "servicequik-pub-instance" {
  count = var.count_pub_ec2
  ami = data.aws_ami.data_pub_instance.id //var.pub_ami
  instance_type = var.instance_type
  tenancy = var.tenancy
  subnet_id = var.public_subnet_id[count.index]
  key_name = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  associate_public_ip_address = true  
  availability_zone = var.availability_zones_ec2[count.index]
  tags = {
    Name = "${var.vpc_name}-pub-ec2-${count.index+1}"
  }
}



//resource aws private instance

resource "aws_instance" "servicequik-pri-instance" {
  count = var.count_pri_ec2
  ami =  data.aws_ami.data_pri_instance.id  // var.pri_ami
  instance_type = var.instance_type
  tenancy = var.tenancy
  subnet_id = var.private_subnet_id[count.index]
  key_name = var.key_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  associate_public_ip_address = false
  availability_zone = var.availability_zones_ec2[count.index]
  tags = {
    Name = "${var.vpc_name}-pri-ec2-${count.index+1}"
  }
}

