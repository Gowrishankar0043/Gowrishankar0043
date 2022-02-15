output "aws_subnet_public" {
  value = aws_subnet.public
}

output "aws_subnet_private" {
  value = aws_subnet.private
}

output "aws_route_table_public" {
  value = aws_route_table.public
}

output "aws_route_table_private" {
  value = aws_route_table.private
}

output "aws_network_acl_public" {
  value = aws_network_acl.public
}

output "aws_network_acl_private" {
  value = aws_network_acl.private
}

output "aws_nat_gateway_id" {
  value = aws_nat_gateway.aws_nat.id
}