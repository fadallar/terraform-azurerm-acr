module "diagnostics" {
  source  = "app.terraform.io/fabbuildingblocks/diagnostics-settings/azurerm"
  version = "0.1.2"
  
  resource_id = azurerm_container_registry.registry.id

  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories
  retention_days        = var.logs_retention_days

  custom_name    = var.custom_diagnostic_settings_name
}