variable "role" {
  description = "AWS Role to assume for cross acoount"
  type        = string
  default     = "tfc-admin"
}
variable "region" {
  description = "The region where the resource needs to be deployed"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name for the shared resource"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "igw_id" {
  description = "The Internet Gateway ID"
  type        = string
}

variable "public_subnet" {
  description = "The public subnet"
  type = object({
    names             = list(string)
    availability_zone = list(string)
    cidr_blocks       = list(string)
  })

  validation {
    condition     = length(var.public_subnet.names) == length(var.public_subnet.availability_zone) && length(var.public_subnet.names) == length(var.public_subnet.cidr_blocks) && length(var.public_subnet.availability_zone) == length(var.public_subnet.cidr_blocks)
    error_message = "The Length of names, availability_zone and cidr_block for the public should be same."
  }
}

variable "private_subnet" {
  description = "The private subnet"
  type = object({
    names             = list(string)
    availability_zone = list(string)
    cidr_blocks       = list(string)
  })

  validation {
    condition     = length(var.private_subnet.names) == length(var.private_subnet.availability_zone) && length(var.private_subnet.names) == length(var.private_subnet.cidr_blocks) && length(var.private_subnet.availability_zone) == length(var.private_subnet.cidr_blocks)
    error_message = "The Length of names, availability_zone and cidr_block for the public should be same."
  }
}

variable "public_route_table_name" {
  description = "The public route table name"
  type        = string
  default     = ""
}

variable "create_public_route_table" {
  description = "Should new public route table be created"
  type        = bool
  default     = true
}

variable "public_route_table_id" {
  description = "The public route table id"
  type        = string
  default     = ""
}

variable "private_route_table_name" {
  description = "The private route table name"
  type        = string
  default     = ""

}

variable "create_private_route_table" {
  description = "Should new private route table be created"
  type        = bool
  default     = true
}

variable "private_route_table_id" {
  description = "The public route table id"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags for the Subnets"

  type = map(any)
  default = {
    Application = "Shared VPC",
    Environment = "Non Prod",
    OrgAbbr     = "Cloud",
    OrgName     = "Adv Tech - Cloud",
    Owner       = "cloud-isys-employees@geappliances.com",
    Role        = "VPC"
  }
}

variable "aws_eip_name" {
  description = "The EIP name"
  type        = string
}

variable "aws_nat_name" {
  description = "The nat name"
  type        = string
}

variable "aws_public_network_acl_name" {
  description = "The aws public network acl name"
  type        = string
}

variable "aws_private_network_acl_name" {
  description = "The aws private network acl name"
  type        = string
}

variable "s3_endpoint" {
  description = "The S3 VPC Endpoint"
  type        = string
}

variable "dynamo_db_endpoint" {
  description = "The S3 VPC Endpoint"
  type        = string
}

variable "private_route_table_entries" {
  description = "The private route table entries for the subnets"
  type        = list(map(string))
  # validation {
  #   condition = alltrue([
  #     for rt in var.private_route_table_entries : 
  #   ])
  #   error_message = "One or more value is allowed."
  # }

  # type = list(object({
  #   destination_cidr_block    = string,
  #   carrier_gateway_id        = string,
  #   egress_only_gateway_id    = string,
  #   gateway_id                = string,
  #   instance_id               = string,
  #   nat_gateway_id            = string,
  #   local_gateway_id          = string,
  #   network_interface_id      = string,
  #   transit_gateway_id        = string,
  #   vpc_endpoint_id           = string,
  #   vpc_peering_connection_id = string
  # }))
  default = []
}

variable "public_route_table_entries" {
  description = "The public route table entries for the subnets"
  type        = list(map(string))

  # type = list(object({
  #   destination_cidr_block    = string,
  #   carrier_gateway_id        = string,
  #   egress_only_gateway_id    = string,
  #   gateway_id                = string,
  #   instance_id               = string,
  #   nat_gateway_id            = string,
  #   local_gateway_id          = string,
  #   network_interface_id      = string,
  #   transit_gateway_id        = string,
  #   vpc_endpoint_id           = string,
  #   vpc_peering_connection_id = string
  # }))
  default = []

}

variable "public_network_acls_entries" {
  description = "The public network acls entries for the subnets"

  type = list(map(string))
  # type = list(object({
  #   rule_number     = string,
  #   egress          = string,
  #   protocol        = string,
  #   rule_action     = string,
  #   cidr_block      = string,
  #   ipv6_cidr_block = string,
  #   from_port       = string,
  #   to_port         = string,
  #   icmp_type       = string,
  #   icmp_code       = string
  # }))
  default = []

}

variable "private_network_acls_entries" {
  description = "The private network acls entries for the subnets"
  type        = list(map(string))

  # type = list(object({
  #   rule_number     = string,
  #   egress          = string,
  #   protocol        = string,
  #   rule_action     = string,
  #   cidr_block      = string,
  #   ipv6_cidr_block = string,
  #   from_port       = string,
  #   to_port         = string,
  #   icmp_type       = string,
  #   icmp_code       = string
  # }))
  default = []

}

variable "attach_VPC_to_TGW" {
  description = "Should the VPC be attached to TGW"
  type        = bool
  default     = false
}

variable "tgw_id" {
  description = "The Transit Gateway ID"
  type        = string
  default     = null
}

variable "tgw_rtb_propogation_id" {
  description = "The Transit Gateway route table ID where the vpcs need to be propogated"
  type        = string
  default     = null
}

variable "tgw_rtb_association_id" {
  description = "The Transit Gateway route table ID where the vpcs need to be associated"
  type        = string
  default     = null
}