variable "diagnostic_settings_name" {  
  description = "Name of the diagnostics settings, name will be 'default' if not set."  
  type        = string  
  default     = "default"
}

variable "diag_log_analytics_workspace_id" {
  type = string
  description = " Log Analytics Workspace Id for logs and metrics diagnostics destination"
}

variable "diag_storage_account_id" {
  description = " Storage Account Id for logs and metrics diagnostics destination"
  type = string
  default = null
}

variable "diag_metric_categories" {
  description = "List of metric categories to enable in the diagnostic settings"
  type = list(string)
  default = ["AllMetrics"]
}
variable "diag_log_categories" {
  description = "List of categories to enable in the diagnostic settings"
  type = list(string)
  default = [
    "ContainerRegistryRepositoryEvents",
    "LoginEvents"
  ]

}

variable "diag_retention_days" {
  description = "The number of days for which the Retention Policy should apply"
  type = number
  default = 30
}