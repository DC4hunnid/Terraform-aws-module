data "aws_route_table" "vpc-peering-accepter-route-table" {
  route_table_id = var.route_table_id
}

resource "aws_route" "vpc-peering-accepter-route" {
  route_table_id = data.aws_route_table.vpc-peering-accepter-route-table.id
  destination_cidr_block = var.vpc_peering_requester_destination_cidr_block
  vpc_peering_connection_id = var.vpc_peering_connection_id
}
