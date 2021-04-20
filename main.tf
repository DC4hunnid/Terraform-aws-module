terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}



module "servicequik_vpc" {
  source = "./modules/vpc"

//VPC
  vpc_name = var.vpc_name
  vpc_id = module.servicequik_vpc.vpc_id
  vpc_cidr = var.vpc_cidr

//Subnet
  pub_subnet_cidr_block = var.pub_subnet_cidr_block
  pri_subnet_cidr_block = var.pri_subnet_cidr_block
  count_pub_subnet = var.count_pub_subnet
  count_pri_subnet = var.count_pri_subnet
  
//Elastic IP
  eip_id = module.servicequik_vpc.eip_id

//NAT Gateway
  nat_gateway_id = module.servicequik_vpc.nat_gateway_id

//Route Table
  public_rt_id = module.servicequik_vpc.public_rt_id
  private_rt_id = module.servicequik_vpc.private_rt_id

//Private Route Table Count
 //count_pri_rt = var.count_pri_rt

//Public Route Table Association
  count_aso_pub_rt = var.count_aso_pub_rt

//Private Route Table Association
  count_aso_pri_rt = var.count_aso_pri_rt

//Internet Gateway
  gateway_id = module.servicequik_vpc.gateway_id

//Availability Zones
  availability_zones = var.availability_zones
  //security_group_id = module.servicequik_vpc.security_group_id

//VPC Peering
  vpc_peering_connection_id = module.servicequik_vpc_peering.vpc_peering_connection_id
  vpc_peering_accepter_cidr_block = var.vpc_peering_accepter_cidr_block
}



module "servicequik_nacl" {
  source = "./modules/nacl"
  vpc_id = module.servicequik_vpc.vpc_id
  vpc_name = var.vpc_name
  public_subnet_id = module.servicequik_vpc.public_subnet_id
  private_subnet_id = module.servicequik_vpc.private_subnet_id
  //pub_network_interface_id = module.servicequik_ec2.pub_network_interface_id
  //pri_network_interface_id = module.servicequik_ec2.pri_network_interface_id
  pub_nacl_egress_cidr_block = var.pub_nacl_egress_cidr_block
  pub_nacl_ingress_cidr_block = var.pub_nacl_ingress_cidr_block
  pri_nacl_egress_cidr_block = var.pri_nacl_egress_cidr_block
  pri_nacl_ingress_cidr_block = var.pri_nacl_ingress_cidr_block
}



module "servicequik_sg" {
  source = "./modules/sg"
  vpc_id = module.servicequik_vpc.vpc_id
  vpc_name = var.vpc_name
  trusted_ip_ingress = var.trusted_ip_ingress
  trusted_ip_ingress_all_traffic = var.trusted_ip_ingress_all_traffic
  trusted_ip_egress = var.trusted_ip_egress
}



module "servicequik_ec2" {
  source = "./modules/ec2"
  count_pub_ec2 = var.count_pub_ec2
  count_pri_ec2 = var.count_pri_ec2
  //pub_ami = var.pub_ami
  //pri_ami = var.pri_ami
  instance_type = var.instance_type
  tenancy = var.tenancy
  key_name = var.key_name
  vpc_security_group_ids = module.servicequik_sg.vpc_security_group_ids
  availability_zones_ec2 = var.availability_zones_ec2
  public_subnet_id = module.servicequik_vpc.public_subnet_id
  private_subnet_id = module.servicequik_vpc.private_subnet_id
  vpc_name = var.vpc_name

//data source aws_ami for public instance

  most_recent_pub_instance = var.most_recent_pub_instance
  name_values_pub_instance = var.name_values_pub_instance
  virtualization_type_values_pub_instance = var.virtualization_type_values_pub_instance
  owners_pub_instance = var.owners_pub_instance

//data source aws_ami for private instance

  most_recent_pri_instance = var.most_recent_pri_instance
  name_values_pri_instance = var.name_values_pri_instance
  virtualization_type_values_pri_instance = var.virtualization_type_values_pri_instance
  owners_pri_instance = var.owners_pri_instance
}



module "servicequik_vpc_peering" {
  source = "./modules/vpcpeering"
  vpc_requester_id = module.servicequik_vpc.vpc_id
  vpc_accepter_id = var.vpc_accepter_id
  peer_region = var.peer_region
  vpc_name = var.vpc_name
  //vpc_id = module.servicequik_vpc.vpc_id
}



module "servicequik_accepter_rt" {
  source = "./modules/accepter_rt"
  route_table_id = var.vpc_accepter_route_table_id
  vpc_peering_requester_destination_cidr_block = var.vpc_peering_requester_destination_cidr_block
  vpc_peering_connection_id = module.servicequik_vpc_peering.vpc_peering_connection_id
}
