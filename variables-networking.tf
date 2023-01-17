variable "allowed_subnets" {
  description = "List of VNet/Subnet IDs to allow on the registry."
  default     = []
  type        = list(string)
}

variable "public_network_access_enabled" {
  description = "Whether the Container Registry is accessible publicly."
  type        = bool
  default     = false
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU)."
  default     = false
  type        = bool
}
variable "enable_private_endpoint" {
  description = "Static Site Private DNS Zone id. Required if private endpoint is enabled"
  type        = bool
  default     = true
}

variable "private_dns_zone_ids" {
  description = "Id of the private DNS Zone  to be used by the container registry private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "Id for the subnet used by the container registry private endpoint"
  type        = string
}

variable "allowed_cidrs" {
  description = "List of CIDRs to allow on the registry."
  default     = []
  type        = list(string)
}