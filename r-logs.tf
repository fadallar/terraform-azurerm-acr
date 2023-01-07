module "diagnostics" {
  source  = "app.terraform.io/dallaraCorp/diagnostics-settings/azurerm"
  version = "0.1.1"
  resource_id = azurerm_container_registry.registry.id

  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories
  retention_days        = var.logs_retention_days

  use_caf_naming = var.use_caf_naming
  custom_name    = var.custom_diagnostic_settings_name
  name_prefix    = var.name_prefix
  name_suffix    = var.name_suffix
}