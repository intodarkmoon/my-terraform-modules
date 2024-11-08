
variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using ipv4_netmask_length."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults to true."
  type        = bool
  default     = null
}

variable "enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
  default     = false
}

variable "instance_tenancy" {
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee."
  type        = string
  default     = "default"
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}


################################################################################
# Subnets Variables
################################################################################
variable "azs" {
  description = "(Optional) List AZ for the subnet."
  type        = list(string)
  default     = []
}

variable "public_cidr_subnet" {
  description = "(Optional) List of IPv4 CIDR block for the Public Subnet"
  type        = list(string)
  default     = []

}

variable "private_cidr_subnet" {
  description = "(Optional) List of IPv4 CIDR block for the Private Subnet"
  type        = list(string)
  default     = []

}

variable "public_subnet" {
  description = "value"
}
