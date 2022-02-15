################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "public" {
  count                   = local.public_count
  vpc_id                  = var.vpc_id
  availability_zone       = var.public_subnet.availability_zone[count.index]
  cidr_block              = var.public_subnet.cidr_blocks[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    {
      "Name" = format("%s", var.public_subnet.names[count.index])
    },
    var.tags,
  )
}
