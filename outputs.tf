output "aws_shared_vpc_id" {
  value = aws_vpc.shared_vpc.id
}

output "aws_internet_gateway_id" {
  value = aws_internet_gateway.aws_igw.id
}

output "aws_vpc_endpoint_s3_id" {
  value = aws_vpc_endpoint.s3.id
}

output "aws_vpc_endpoint_dynamo_db_id" {
  value = aws_vpc_endpoint.dynamo_db.id
}

output "aws_nat_gateway_id" {
  value = module.subnets.aws_nat_gateway_id
}
output "subnet" {
  value = module.subnets
}