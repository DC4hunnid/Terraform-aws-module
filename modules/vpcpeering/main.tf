data "aws_vpc" "accepter" {
  id = var.vpc_accepter_id
}


/*
data  "aws_vpc" "requester-vpc" {
  id = var.vpc_requester_id
}

data "aws_vpc" "accepter-vpc" {
  id = var.vpc_accepter_id
}
*/

resource "aws_vpc_peering_connection" "peering-vpc" {
  //peer_owner_id = "${var.peer_owner_id}"
  vpc_id = var.vpc_requester_id
  peer_vpc_id = data.aws_vpc.accepter.id
  peer_region = var.peer_region
  //auto_accept = true
  tags = {
    Name = "${var.vpc_name}-vpc-peering"
  }
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = aws_vpc_peering_connection.peering-vpc.id
  auto_accept = true
  tags = {
    Name = "${var.vpc_name}-vpc-peering"
  }
}
