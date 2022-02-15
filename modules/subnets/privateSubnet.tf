################################################################################
# Private subnet
################################################################################

resource "aws_subnet" "private" {
  count                   = local.private_count
  vpc_id                  = var.vpc_id
  availability_zone       = var.private_subnet.availability_zone[count.index]
  cidr_block              = var.private_subnet.cidr_blocks[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      "Name" = format("%s", var.private_subnet.names[count.index])
    },
    var.tags,
  )
}