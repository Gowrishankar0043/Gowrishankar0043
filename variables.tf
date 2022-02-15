################################################################################
# VPC
################################################################################

variable "account" {
  description = "Account in which the VPC needs to be created"
  type        = string
}

variable "role" {
  description = "AWS Role to assume for cross acoount"
  type        = string
  default     = "tfc-admin"
}

variable "account_role" {
  description = "Account Cross Account Role"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(any)
  default = {
    Application = "Shared VPC",
    Environment = "Non Prod",
    OrgAbbr     = "Cloud",
    OrgName     = "Adv Tech - Cloud",
    Owner       = "cloud-isys-employees@geappliances.com",
    Role        = "VPC",
  }
}

variable "aws_igw_name" {
  description = "Name of the AWS Internet Gateway"
  type        = string
  default     = ""
}

variable "aws_vpc_endpoint_s3_name" {
  description = "Name of the AWS S3 VPC Endpoint"
  type        = string
  default     = ""
}

variable "aws_vpc_endpoint_dynamo_db_name" {
  description = "Name of the AWS DynamoDB VPC Endpoint"
  type        = string
  default     = ""
}

variable "eip_name" {
  description = "The EIP name"
  type        = string
  default     = ""
}

variable "nat_name" {
  description = "The nat name"
  type        = string
  default     = ""
}

variable "public_network_acl_name" {
  description = "The aws public network acl name"
  type        = string
  default     = ""
}

variable "private_network_acl_name" {
  description = "The aws private network acl name"
  type        = string
  default     = ""
}

variable "attach_VPC_to_TGW" {
  description = "Should the VPC be attached to Transit Gateway"
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