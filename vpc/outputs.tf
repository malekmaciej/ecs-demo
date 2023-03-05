output "route_table_private_1_id" {
  value = aws_route_table.private-01.id
}

output "route_table_private_2_id" {
  value = aws_route_table.private-02.id
}

output "subnet_1-id" {
  value = aws_subnet.private-1.id
}

output "subnet_2-id" {
  value = aws_subnet.private-1.id
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}