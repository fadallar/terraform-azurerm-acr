output "acr_id" {
  description = "The Container Registry ID."
  value       = azurerm_container_registry.registry.id
}

output "acr_name" {
  description = "The Container Registry name."
  value       = azurerm_container_registry.registry.name
}

#output "login_server" {
#  description = "The URL that can be used to log into the container registry."
#  value       = azurerm_container_registry.registry.login_server
#}
#
output "acr_fqdn" {
  description = "The Container Registry FQDN."
  value       = azurerm_container_registry.registry.login_server
}

output "id_acr_pull" {
  description = "Id to the user-managed identity with ACrPull Role"
  value = azurerm_user_assigned_identity.acr_pull.id
}

output "id_acr_push" {
  description = "Id to the user-managed identity with ACrPush Role"
  value = azurerm_user_assigned_identity.acr_push.id
}