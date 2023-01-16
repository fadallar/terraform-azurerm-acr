// ACR PULL
resource "azurerm_user_assigned_identity" "acr_pull" {
  location            = var.location
  name                = format("id-acrpull-%s",azurerm_container_registry.registry.name)
  resource_group_name = var.resource_group_name.default_tags
  tags = var.default_tags
}

resource "azurerm_role_assignment" "rbac_acr_pull" {
  scope                = azurerm_container_registry.registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.acr_pull.id
}

// ACR PUSH

resource "azurerm_user_assigned_identity" "acr_push" {
  location            = var.location
  name                = format("id-acrpush-%s",azurerm_container_registry.registry.name)
  resource_group_name = var.resource_group_name.default_tags
  tags = var.default_tags
}

resource "azurerm_role_assignment" "rbac_acr_push" {
  scope                = azurerm_container_registry.registry.id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.acr_push.id
}