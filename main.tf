provider "aws" {
  assume_role {
    # The role ARN within Account B to AssumeRole into. Created in step 1.
    role_arn = "arn:aws:iam::${var.account}:role/${var.account_role}"
  }
  region = var.region
  # profile = "tas"
}
locals {
  region = var.region
}

################################################################################
# VPC
################################################################################

resource "aws_vpc" "shared_vpc" {

  cidr_block = var.cidr
  # instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.vpc_tags,
  )
}

################################################################################
# Subnets
################################################################################

module "subnets" {
  source = "./modules/subnets"
  # version     = "x.x.x"
  # Tags
  tags     = var.vpc_tags
  vpc_name = var.vpc_name
  vpc_id   = aws_vpc.shared_vpc.id
  vpc_cidr = var.cidr
  region   = var.region
  role     = var.role

  # PUBLIC
  public_subnet = {
    names : ["default-vpc-public1", "default-vpc-public2", "default-vpc-public3"],
    cidr_blocks : ["10.2.16.0/25", "10.2.16.128/25", "10.2.17.0/25"],
    availability_zone : ["us-east-2a", "us-east-2b", "us-east-2c"]
  }
  igw_id                    = aws_internet_gateway.aws_igw.id
  create_public_route_table = true
  public_route_table_name   = "public_route_table_name"

  # PRIVATE
  private_subnet = {
    names : ["default-vpc-private1", "default-vpc-private2", "default-vpc-private3"],
    cidr_blocks : ["10.2.17.128/25", "10.2.18.0/25", "10.2.18.128/25"],
    availability_zone : ["us-east-2a", "us-east-2b", "us-east-2c"]
  }
  create_private_route_table = true
  private_route_table_name   = "private_route_table_name"


  # Route Table

  # Transit Gateway
  attach_VPC_to_TGW      = var.attach_VPC_to_TGW
  tgw_id                 = var.tgw_id
  tgw_rtb_propogation_id = var.tgw_rtb_propogation_id
  tgw_rtb_association_id = var.tgw_rtb_association_id


  s3_endpoint                  = aws_vpc_endpoint.s3.id
  dynamo_db_endpoint           = aws_vpc_endpoint.dynamo_db.id
  aws_eip_name                 = var.eip_name
  aws_nat_name                 = var.nat_name
  aws_public_network_acl_name  = var.public_network_acl_name
  aws_private_network_acl_name = var.private_network_acl_name

  # private_route_table_entries = [{
  #   # Mandatory
  #   destination_cidr_block = "",

  #   # Fill Based on Endpoint
  #   carrier_gateway_id        = "",
  #   egress_only_gateway_id    = "",
  #   gateway_id                = "",
  #   instance_id               = "",
  #   nat_gateway_id            = "",
  #   local_gateway_id          = "",
  #   network_interface_id      = "",
  #   transit_gateway_id        = "",
  #   vpc_endpoint_id           = "",
  #   vpc_peering_connection_id = ""
  # }]

  # public_route_table_entries = [{
  #   # Mandatory
  #   destination_cidr_block = "",

  #   # Fill Based on Endpoint
  #   carrier_gateway_id        = "",
  #   egress_only_gateway_id    = "",
  #   gateway_id                = "",
  #   instance_id               = "",
  #   nat_gateway_id            = "",
  #   local_gateway_id          = "",
  #   network_interface_id      = "",
  #   transit_gateway_id        = "",
  #   vpc_endpoint_id           = "",
  #   vpc_peering_connection_id = ""
  # }]

  # NACL 
  # public_network_acls_entries = [{
  #   rule_number     = "",
  #   egress          = "",
  #   protocol        = "",
  #   rule_action     = "",
  #   cidr_block      = "",
  #   ipv6_cidr_block = "",
  #   from_port       = "",
  #   to_port         = "",
  #   icmp_type       = "",
  #   icmp_code       = ""
  # }]

  # private_network_acls_entries = [{
  #   rule_number     = "",
  #   egress          = "",
  #   protocol        = "",
  #   rule_action     = "",
  #   cidr_block      = "",
  #   ipv6_cidr_block = "",
  #   from_port       = "",
  #   to_port         = "",
  #   icmp_type       = "",
  #   icmp_code       = ""
  # }]
}

################################################################################
# Internet Gateway
################################################################################

resource "aws_internet_gateway" "aws_igw" {
  vpc_id = aws_vpc.shared_vpc.id

  tags = merge(
    {
      "Name" = format("%s", var.aws_igw_name)
    },
    var.vpc_tags
  )
}

################################################################################
# S3 VPC Endpoint
###############6#################################################################

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.shared_vpc.id
  service_name = "com.amazonaws.${var.region}.s3"

  tags = merge(
    {
      "Name" = format("%s", var.aws_vpc_endpoint_s3_name)
    },
    var.vpc_tags
  )

}

################################################################################
# DynamoDB VPC Endpoint
###############6#################################################################

resource "aws_vpc_endpoint" "dynamo_db" {
  vpc_id       = aws_vpc.shared_vpc.id
  service_name = "com.amazonaws.${var.region}.dynamodb"
  policy       = <<POLICY
    {
      "Statement": [
        {
          "Action": "*",
          "Effect": "Allow",
          "Resource": "*",
          "Principal": "*"
        }
      ]
    }
    POLICY

  tags = merge(
    {
      "Name" = format("%s", var.aws_vpc_endpoint_dynamo_db_name)
    },
    var.vpc_tags
  )
}
