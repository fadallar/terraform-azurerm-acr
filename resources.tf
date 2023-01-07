resource "azurerm_container_registry" "registry" {
  name = local.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  # Our practice is to disable admin access on our ACR
  admin_enabled = false
  #admin_enabled       = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.azure_services_bypass_allowed ? "AzureServices" : "None"
  data_endpoint_enabled = var.data_endpoint_enabled
  anonymous_pull_enabled = false

  dynamic "retention_policy" {
    for_each = var.images_retention_enabled && var.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.images_retention_enabled
      days    = var.images_retention_days
    }
  }

  dynamic "trust_policy" {
    for_each = var.trust_policy_enabled && var.sku == "Premium" ? ["enabled"] : []

    content {
      enabled = var.trust_policy_enabled
    }
  }

  dynamic "georeplications" {
    for_each = var.georeplication_locations != null && var.sku == "Premium" ? var.georeplication_locations : []

    content {
      location                  = try(georeplications.value.location, georeplications.value)
      zone_redundancy_enabled   = try(georeplications.value.zone_redundancy_enabled, null)
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, null)
      tags                      = try(georeplications.value.tags, null)
    }
  }

  dynamic "network_rule_set" {
    for_each = length(concat(var.allowed_cidrs, var.allowed_subnets)) > 0 ? ["enabled"] : []

    content {
      default_action = "Deny"

      dynamic "ip_rule" {
        for_each = var.allowed_cidrs
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }

      dynamic "virtual_network" {
        for_each = var.allowed_subnets
        content {
          action    = "Allow"
          subnet_id = virtual_network.value
        }
      }
    }
  }

  tags = merge(var.default_tags, var.extra_tags)

  lifecycle {
    precondition {
      condition     = !var.data_endpoint_enabled || var.sku == "Premium"
      error_message = "Premium SKU is mandatory to enable the data endpoints."
    }
  }
}
resource "azurerm_private_endpoint" "registrypep" {
  name                = format("pe-%s", local.acr_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags = merge(var.default_tags, var.extra_tags)
  private_dns_zone_group {
    name                 = "container-registry-group"
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }

  private_service_connection {
    name                           = "containerregistryprivatelink"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_container_registry.registry.id
    subresource_names              = ["registry"]
  }
}