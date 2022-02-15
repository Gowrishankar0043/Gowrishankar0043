# provider "aws" {
#   alias = "tgw"
#   # # (Optional) the MFA token for Account A.
#   # token      = "123456"

#   assume_role {
#     # The role ARN within Account B to AssumeRole into. Created in step 1.
#     role_arn = "arn:aws:iam::655260106862:role/${var.role}"
#     # (Optional) The external ID created in step 1c.
#     # external_id = "my_external_id"
#   }
#   profile = "tas"
#   region  = var.region
# }

locals {
  public_count  = length(var.public_subnet.names)
  private_count = length(var.private_subnet.names)

  default_public_network_acls_entries = [
    # {
    #   rule_number = "100",
    #   egress      = true,
    #   protocol    = "-1",
    #   rule_action = "allow",
    #   cidr_block  = "${var.vpc_cidr}"
    # },
    # {
    #   rule_number = "100",
    #   egress      = false,
    #   protocol    = "-1",
    #   rule_action = "allow",
    #   cidr_block  = "${var.vpc_cidr}"
    # },
    {
      rule_number = "200",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "10.0.0.0/8"
    },
    {
      rule_number = "200",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "10.0.0.0/8"
    },
    {
      rule_number = "250",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "172.16.0.0/12"
    },
    {
      rule_number = "250",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "172.16.0.0/12"
    },
    {
      rule_number = "300",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.13.0.0/16"
    },
    {
      rule_number = "300",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.13.0.0/16"
    },
    {
      rule_number = "301",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.67.0.0/16"
    },
    {
      rule_number = "301",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.67.0.0/16"
    },
    {
      rule_number = "302",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.101.0.0/16"
    },
    {
      rule_number = "302",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.101.0.0/16"
    },
    {
      rule_number = "303",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.110.0.0/16"
    },
    {
      rule_number = "303",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.110.0.0/16"
    },
    {
      rule_number = "304",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.130.0.0/16"
    },
    {
      rule_number = "304",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.130.0.0/16"
    },
    {
      rule_number = "305",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.160.0.0/16"
    },
    {
      rule_number = "305",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.160.0.0/16"
    },
    {
      rule_number = "306",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.165.0.0/16"
    },
    {
      rule_number = "306",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.165.0.0/16"
    },
    {
      rule_number = "307",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.237.64.0/22"
    },
    {
      rule_number = "307",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "3.237.64.0/22"
    },
    {
      rule_number = "999",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = "999",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "0.0.0.0/0"
    }
  ]
  all_public_network_acls_entries = concat(local.default_public_network_acls_entries, var.public_network_acls_entries)

  default_private_network_acls_entries = [
    {
      rule_number = "100",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "${var.vpc_cidr}"
    },
    {
      rule_number = "100",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "${var.vpc_cidr}"
    },
    {
      rule_number = "150",
      egress      = true,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "10.0.0.0/12"
    },
    {
      rule_number = "150",
      egress      = false,
      protocol    = "-1",
      rule_action = "deny",
      cidr_block  = "10.0.0.0/12"
    },
    {
      rule_number = "200",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "10.0.0.0/8"
    },
    {
      rule_number = "200",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "10.0.0.0/8"
    },
    {
      rule_number = "250",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "172.16.0.0/12"
    },
    {
      rule_number = "250",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "172.16.0.0/12"
    },
    {
      rule_number = "300",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.13.0.0/16"
    },
    {
      rule_number = "300",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.13.0.0/16"
    },
    {
      rule_number = "301",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.67.0.0/16"
    },
    {
      rule_number = "301",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.67.0.0/16"
    },
    {
      rule_number = "302",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.101.0.0/16"
    },
    {
      rule_number = "302",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.101.0.0/16"
    },
    {
      rule_number = "303",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.110.0.0/16"
    },
    {
      rule_number = "303",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.110.0.0/16"
    },
    {
      rule_number = "304",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.130.0.0/16"
    },
    {
      rule_number = "304",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.130.0.0/16"
    },
    {
      rule_number = "305",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.160.0.0/16"
    },
    {
      rule_number = "305",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.160.0.0/16"
    },
    {
      rule_number = "306",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.165.0.0/16"
    },
    {
      rule_number = "306",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.165.0.0/16"
    },
    {
      rule_number = "307",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.237.64.0/22"
    },
    {
      rule_number = "307",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "3.237.64.0/22"
    },
    {
      rule_number = "999",
      egress      = true,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = "999",
      egress      = false,
      protocol    = "-1",
      rule_action = "allow",
      cidr_block  = "0.0.0.0/0"
    }
  ]

  all_private_network_acls_entries = concat(local.default_private_network_acls_entries, var.private_network_acls_entries)
}

################################################################################
# Public Network ACLs
################################################################################

resource "aws_network_acl" "public" {
  vpc_id     = var.vpc_id
  subnet_ids = aws_subnet.public.*.id

  tags = merge(
    {
      "Name" = format("%s", var.aws_public_network_acl_name)
    },
    var.tags
  )
}

resource "aws_network_acl_rule" "public" {
  count = length(local.all_public_network_acls_entries)

  network_acl_id = aws_network_acl.public.id

  rule_number     = local.all_public_network_acls_entries[count.index]["rule_number"]
  egress          = local.all_public_network_acls_entries[count.index]["egress"]
  protocol        = local.all_public_network_acls_entries[count.index]["protocol"]
  rule_action     = local.all_public_network_acls_entries[count.index]["rule_action"]
  cidr_block      = lookup(local.all_public_network_acls_entries[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(local.all_public_network_acls_entries[count.index], "ipv6_cidr_block", null)
  from_port       = lookup(local.all_public_network_acls_entries[count.index], "from_port", null)
  to_port         = lookup(local.all_public_network_acls_entries[count.index], "to_port", null)
  icmp_type       = lookup(local.all_public_network_acls_entries[count.index], "icmp_type", null)
  icmp_code       = lookup(local.all_public_network_acls_entries[count.index], "icmp_code", null)
}

################################################################################
# Private Network ACLs
################################################################################

resource "aws_network_acl" "private" {
  vpc_id     = var.vpc_id
  subnet_ids = aws_subnet.private.*.id

  tags = merge(
    {
      "Name" = format("%s", var.aws_private_network_acl_name)
    },
    var.tags
  )
}

resource "aws_network_acl_rule" "private" {
  count = length(local.all_private_network_acls_entries)

  network_acl_id = aws_network_acl.private.id

  rule_number     = local.all_private_network_acls_entries[count.index]["rule_number"]
  egress          = local.all_private_network_acls_entries[count.index]["egress"]
  protocol        = local.all_private_network_acls_entries[count.index]["protocol"]
  rule_action     = local.all_private_network_acls_entries[count.index]["rule_action"]
  cidr_block      = lookup(local.all_private_network_acls_entries[count.index], "cidr_block", null)
  ipv6_cidr_block = lookup(local.all_private_network_acls_entries[count.index], "ipv6_cidr_block", null)
  from_port       = lookup(local.all_private_network_acls_entries[count.index], "from_port", null)
  to_port         = lookup(local.all_private_network_acls_entries[count.index], "to_port", null)
  icmp_type       = lookup(local.all_private_network_acls_entries[count.index], "icmp_type", null)
  icmp_code       = lookup(local.all_private_network_acls_entries[count.index], "icmp_code", null)
}

################################################################################
# NAT Gateway
################################################################################

resource "aws_eip" "nat" {
  vpc = true

  tags = merge(
    {
      "Name" = format("%s", var.aws_eip_name)
    },
    var.tags
  )
}

resource "aws_nat_gateway" "aws_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    {
      "Name" = format("%s", var.aws_nat_name)
    },
    var.tags
  )
}

################################################################################
# Transit Gateway
################################################################################

resource "aws_ec2_transit_gateway_vpc_attachment" "shared_vpc" {
  count = var.attach_VPC_to_TGW ? 1 : 0

  subnet_ids         = aws_subnet.private.*.id
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", "aws-network-tgw-p-01-${var.region}-${var.vpc_name}")
    },
    var.tags
  )

  depends_on = [aws_subnet.private, aws_subnet.public]
}

# resource "aws_ec2_transit_gateway_route_table_association" "shared_vpc" {
#   provider    = aws.tgw

#   count = var.attach_VPC_to_TGW ? 1 : 0

#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_vpc[0].id
#   transit_gateway_route_table_id = var.tgw_rtb_association_id
# }

# resource "aws_ec2_transit_gateway_route_table_propagation" "shared_vpc" {
#   provider    = aws.tgw

#   count = var.attach_VPC_to_TGW ? 1 : 0

#   transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.shared_vpc[0].id
#   transit_gateway_route_table_id = var.tgw_rtb_propogation_id
# }

locals {
  tgw_routes = ["10.0.0.0/8", "172.16.0.0/12", "3.130.0.0/16"]
}

resource "aws_route" "private_tgw_routes" {
  count = var.create_private_route_table && var.attach_VPC_to_TGW ? length(local.tgw_routes) : 0

  route_table_id         = aws_route_table.private[0].id
  transit_gateway_id     = var.tgw_id
  destination_cidr_block = local.tgw_routes[count.index]
}