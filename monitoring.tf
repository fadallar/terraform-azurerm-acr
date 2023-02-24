// Please check issue https://github.com/hashicorp/terraform-provider-azurerm/issues/17172

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name                       = var.diag_default_setting_name
  target_resource_id         = azurerm_container_registry.registry.id
  log_analytics_destination_type = var.log_analytics_destination_type
  log_analytics_workspace_id = var.diag_log_analytics_workspace_id
  storage_account_id = var.diag_storage_account_id

  dynamic "metric" {
    for_each = var.diag_metric_categories
    content {
      category = metric.value
      enabled  = true
      retention_policy {
        days    = var.diag_retention_days
        enabled = true
      }
    }
  }

  dynamic "enabled_log" {
    for_each = var.diag_log_categories
    content {
      category = enabled_log.value
      enabled  = true
      retention_policy {
        days    = var.diag_retention_days
        enabled = true
      }
    }
  }
}