################################################################################
# Publiс routes
################################################################################

resource "aws_route_table" "public" {
  count  = var.create_public_route_table ? 1 : 0
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.public_route_table_name)
    },
    var.tags,
  )
}

resource "aws_route" "public_igw" {
  count = var.create_public_route_table ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  gateway_id             = var.igw_id == "" ? null : var.igw_id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "public" {
  count = var.create_public_route_table ? length(var.public_route_table_entries) : 0

  route_table_id            = aws_route_table.public[0].id
  destination_cidr_block    = var.public_route_table_entries[count.index]["destination_cidr_block"]
  carrier_gateway_id        = lookup(var.public_route_table_entries[count.index], "carrier_gateway_id", null)
  egress_only_gateway_id    = lookup(var.public_route_table_entries[count.index], "egress_only_gateway_id", null)
  gateway_id                = lookup(var.public_route_table_entries[count.index], "gateway_id", null)
  instance_id               = lookup(var.public_route_table_entries[count.index], "instance_id", null)
  nat_gateway_id            = lookup(var.public_route_table_entries[count.index], "nat_gateway_id", null)
  local_gateway_id          = lookup(var.public_route_table_entries[count.index], "local_gateway_id", null)
  network_interface_id      = lookup(var.public_route_table_entries[count.index], "network_interface_id", null)
  transit_gateway_id        = lookup(var.public_route_table_entries[count.index], "transit_gateway_id", null)
  vpc_endpoint_id           = lookup(var.public_route_table_entries[count.index], "vpc_endpoint_id", null)
  vpc_peering_connection_id = lookup(var.public_route_table_entries[count.index], "vpc_peering_connection_id", null)
}

################################################################################
# Private routes
# There are as many routing tables as the number of NAT gateways
################################################################################

resource "aws_route_table" "private" {
  count  = var.create_private_route_table ? 1 : 0
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.private_route_table_name)
    },
    var.tags
  )
}

resource "aws_route" "private_nat" {
  count = var.create_private_route_table ? 1 : 0

  route_table_id         = aws_route_table.private[0].id
  nat_gateway_id         = aws_nat_gateway.aws_nat.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private" {
  count = var.create_private_route_table ? length(var.private_route_table_entries) : 0

  route_table_id            = aws_route_table.private[0].id
  destination_cidr_block    = var.private_route_table_entries[count.index]["destination_cidr_block"]
  carrier_gateway_id        = lookup(var.private_route_table_entries[count.index], "carrier_gateway_id", null)
  egress_only_gateway_id    = lookup(var.private_route_table_entries[count.index], "egress_only_gateway_id", null)
  gateway_id                = lookup(var.private_route_table_entries[count.index], "gateway_id", null)
  instance_id               = lookup(var.private_route_table_entries[count.index], "instance_id", null)
  nat_gateway_id            = lookup(var.private_route_table_entries[count.index], "nat_gateway_id", null)
  local_gateway_id          = lookup(var.private_route_table_entries[count.index], "local_gateway_id", null)
  network_interface_id      = lookup(var.private_route_table_entries[count.index], "network_interface_id", null)
  transit_gateway_id        = lookup(var.private_route_table_entries[count.index], "transit_gateway_id", null)
  vpc_endpoint_id           = lookup(var.private_route_table_entries[count.index], "vpc_endpoint_id", null)
  vpc_peering_connection_id = lookup(var.private_route_table_entries[count.index], "vpc_peering_connection_id", null)
}

# associate route table with VPC endpoint
resource "aws_vpc_endpoint_route_table_association" "s3_endpoint_route_table_association" {
  count = var.create_private_route_table ? 1 : 0

  route_table_id  = aws_route_table.private[0].id
  vpc_endpoint_id = var.s3_endpoint
}

# associate route table with VPC endpoint
resource "aws_vpc_endpoint_route_table_association" "dynamo_db_endpoint_route_table_association" {
  count = var.create_private_route_table ? 1 : 0

  route_table_id  = aws_route_table.private[0].id
  vpc_endpoint_id = var.dynamo_db_endpoint
}

################################################################################
# Route table association
################################################################################

resource "aws_route_table_association" "private" {
  count          = var.create_private_route_table ? local.private_count : 0
  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = var.create_public_route_table ? aws_route_table.private[0].id : var.private_route_table_id
}

resource "aws_route_table_association" "public" {
  count          = var.create_public_route_table ? local.public_count : 0
  subnet_id      = aws_subnet.public.*.id[count.index]
  route_table_id = var.create_private_route_table ? aws_route_table.public[0].id : var.public_route_table_id
}
