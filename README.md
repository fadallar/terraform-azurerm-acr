# Azure Container Registry
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/)

This Terraform module creates an Azure Container Registry.
  - It generates an ACR resource name following our naming convention
  - It applies a default diagnostics settings  
  - It configures a private endpoint if private access is enabled
  - It configures ACR firewall if public network access is enabled
  - It configures user managed identities scoped at the ACR for AcrPull and AcrPush roles

The module support the creation of a geo redundant ACR

>You can overide the generated name using the custom_name parameter

> Important  
> Ensures you have the required permissions to associate a role to a user managed identity  

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.22 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.22 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_container_registry.registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.registrypep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.rbac_acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_acr_push](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.acr_pull](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.acr_push](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [azurerm_monitor_diagnostic_categories.diagcategories](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Project environment. | `string` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym,it will beused to generate the resource nae | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure region to use. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | Id of the private DNS Zone  to be used by the container registry private endpoint | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group. | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Project stack name. | `string` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Id for the subnet used by the container registry private endpoint | `string` | n/a | yes |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs to allow on the registry. | `list(string)` | `[]` | no |
| <a name="input_allowed_subnets"></a> [allowed\_subnets](#input\_allowed\_subnets) | List of VNet/Subnet IDs to allow on the registry. | `list(string)` | `[]` | no |
| <a name="input_azure_services_bypass_allowed"></a> [azure\_services\_bypass\_allowed](#input\_azure\_services\_bypass\_allowed) | Whether to allow trusted Azure services to access a network restricted Container Registry. | `bool` | `true` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom resource name, it will overide the generated name if set | `string` | `""` | no |
| <a name="input_data_endpoint_enabled"></a> [data\_endpoint\_enabled](#input\_data\_endpoint\_enabled) | Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU). | `bool` | `false` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Static Site Private DNS Zone id. Required if private endpoint is enabled | `bool` | `true` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_georeplication_locations"></a> [georeplication\_locations](#input\_georeplication\_locations) | A list of Azure locations where the Ccontainer Registry should be geo-replicated. Only activated on Premium SKU.<br>  Supported properties are:<br>    location                  = string<br>    zone\_redundancy\_enabled   = bool<br>    regional\_endpoint\_enabled = bool<br>    tags                      = map(string)<br>  or this can be a list of `string` (each element is a location) | `any` | `[]` | no |
| <a name="input_images_retention_days"></a> [images\_retention\_days](#input\_images\_retention\_days) | Specifies the number of images retention days. | `number` | `90` | no |
| <a name="input_images_retention_enabled"></a> [images\_retention\_enabled](#input\_images\_retention\_enabled) | Specifies whether images retention is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the Container Registry is accessible publicly. | `bool` | `false` | no |
| <a name="input_quarantine_policy_enabled"></a> [quarantine\_policy\_enabled](#input\_quarantine\_policy\_enabled) | Boolean value that indicates whether quarantine policy is enabled. Only available with premium SKU | `bool` | `false` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU name of the the container registry. Possible values are `Basic`, `Standard` and `Premium`. | `string` | `"Premium"` | no |
| <a name="input_trust_policy_enabled"></a> [trust\_policy\_enabled](#input\_trust\_policy\_enabled) | Specifies whether the trust policy is enabled (Premium only). | `bool` | `false` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |
| <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled) | Boolean value that indicates whether acr zoe redundancy is enabled. Only available with premium SKU | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acr_fqdn"></a> [acr\_fqdn](#output\_acr\_fqdn) | The Container Registry FQDN. |
| <a name="output_acr_id"></a> [acr\_id](#output\_acr\_id) | The Container Registry ID. |
| <a name="output_acr_name"></a> [acr\_name](#output\_acr\_name) | The Container Registry name. |
| <a name="output_id_acr_pull"></a> [id\_acr\_pull](#output\_id\_acr\_pull) | Id to the user-managed identity with ACrPull Role |
| <a name="output_id_acr_push"></a> [id\_acr\_push](#output\_id\_acr\_push) | Id to the user-managed identity with ACrPush Role |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [Azure Container Registry](https://docs.microsoft.com/en-us/azure/container-registry/).
