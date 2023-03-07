```hcl
module "acr" {
  source  = "app.terraform.io/<your-organization>/regions-master/azurem"
  version = "x.y.z"
  landing_zone_slug = var.landing_zone_slug
  environment = var.environment
  stack       = var.stack
  default_tags                  = module.base-tagging.base_tags
  location                      = module.regions_master.location
  location_short                = module.regions_master.location_short
  resource_group_name           = module.rg.resource_group_name
  
  diag_log_analytics_workspace_id = var.diag_log_analytics_workspace_id
  
  public_network_access_enable = true
  allowed_cidrs = [
    "1.1.1.1",
    "2.2.2.2",
    "3.3.3.3"
    ]
}