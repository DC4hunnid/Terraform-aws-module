terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "servicequik_vpc" {
  source = "./vpc"
  vpc_id = module.servicequik_vpc.vpc_id
  gateway_id = module.servicequik_vpc.gateway_id 
  eip_id = module.servicequik_vpc.eip_id
  public_rt_id = module.servicequik_vpc.public_rt_id
  private_rt_id = module.servicequik_vpc.private_rt_id
}


