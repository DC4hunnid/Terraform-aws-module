output "pub_network_interface_id" {
  value = aws_instance.servicequik-pub-instance[*].primary_network_interface_id
}

output "pri_network_interface_id" {
  value = aws_instance.servicequik-pri-instance[*].primary_network_interface_id
}

output "pub_instance_pub_ip" {
  value = aws_instance.servicequik-pub-instance[*].public_ip
}

output "pub_instance_pri_ip" {
  value = aws_instance.servicequik-pub-instance[*].private_ip
}

output "pri_instance_pri_ip" {
  value = aws_instance.servicequik-pri-instance[*].private_ip
}
