#variable "default_tags_enabled" {
#  description = "Option to enable or disable default tags."
#  type        = bool
#  default     = true
#}
variable "default_tags" {
  description = "Base tags common to all resources"
  type        = map(string)
  default     = {}
}

variable "extra_tags" {
  description = "Additional tags to associate with your Azure Container Registry."
  type        = map(string)
  default     = {}
}