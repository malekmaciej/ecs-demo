output "route_table_private_1_id" {
  value       = aws_route_table.private-01.id
  description = "ID of Route Table for Private Subnet 1"
}

output "route_table_private_2_id" {
  value       = aws_route_table.private-02.id
  description = "ID of Route Table for Private Subnet 2"
}

output "subnet_1_id" {
  value       = aws_subnet.private-1.id
  description = "ID of Private Subnet 1"
}

output "subnet_2_id" {
  value       = aws_subnet.private-2.id
  description = "ID of Private Subnet 2"
}

output "subnet_3_id" {
  value       = aws_subnet.private-3.id
  description = "ID of Private Subnet 3"
}

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "ID of VPC"
}

output "aws_security_group_id" {
  value       = aws_security_group.sg.id
  description = "ID of Security Group"
}