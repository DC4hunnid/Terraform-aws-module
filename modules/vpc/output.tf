output "vpc_id" {
  value = aws_vpc.servicequik.id
}

output "vpc_cidr" {
  value = aws_vpc.servicequik.cidr_block
}

output "public_subnet_id" {
  value = aws_subnet.servicequik-public-subnet[*].id
}

output "private_subnet_id" {
  value = aws_subnet.servicequik-private-subnet[*].id
}

output "public_subnet_cidr" {
  value = aws_subnet.servicequik-public-subnet[*].cidr_block
}

output "private_subnet_cidr" {
  value = aws_subnet.servicequik-private-subnet[*].cidr_block
}

output "eip_id" {
  value = aws_eip.servicequik-eip[*].id
}

output "gateway_id" {
  value = aws_internet_gateway.servicequik-igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.servicequik-nat[*].id
}

output "public_rt_id" {
  value = aws_route_table.public-rt.id
}

output "private_rt_id" {
  value = aws_route_table.private-rt.*.id
}

//output "security_group_id" {
  //value = aws_security_group.servicequik-sg.id
//}
