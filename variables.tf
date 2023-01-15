variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region to use."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "sku" {
  description = "The SKU name of the the container registry. Possible values are `Basic`, `Standard` and `Premium`."
  type        = string
  default     = "Premium"
}
# We do not expose that variable 
#variable "admin_enabled" {
#  description = "Whether the admin user is enabled."
#  type        = bool
#  default     = false
#}
#
variable "georeplication_locations" {
  description = <<DESC
  A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.
  Supported properties are:
    location                  = string
    zone_redundancy_enabled   = bool
    regional_endpoint_enabled = bool
    tags                      = map(string)
  or this can be a list of `string` (each element is a location)
DESC
  type        = any
  default     = []
}

variable "images_retention_enabled" {
  description = "Specifies whether images retention is enabled (Premium only)."
  type        = bool
  default     = false
}

variable "images_retention_days" {
  description = "Specifies the number of images retention days."
  type        = number
  default     = 90
}

variable "azure_services_bypass_allowed" {
  description = "Whether to allow trusted Azure services to access a network restricted Container Registry."
  type        = bool
  default     = true
}

variable "trust_policy_enabled" {
  description = "Specifies whether the trust policy is enabled (Premium only)."
  type        = bool
  default     = false
}

variable "allowed_cidrs" {
  description = "List of CIDRs to allow on the registry."
  default     = []
  type        = list(string)
}

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

variable "quarantine_policy_enabled" {
  description = "Boolean value that indicates whether quarantine policy is enabled. Only available with premium SKU"
  type = bool
  default =false
}

variable "zone_redundancy_enabled" {
    description = "Boolean value that indicates whether acr zoe redundancy is enabled. Only available with premium SKU"
    type = bool
    default = false
}