# Basic Azure Container Registry - Public Access

This is an example for setting-up a an Azure Container Registry

This examples creates
  - Sets the different Azure Region representation ( location, location_short, location_cli ...) --> module "regions_master"
  - Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
  - A resource-group --> module "ressource" 
  - Creates a Premium Azure Container Registry with a secure configuration baseline  
  - Enable Public Access
  - Configure ACR Public access
  - Set the default diagnostics settings (All Logs and metric) whith a Log Analytics workspace as destination 
  - Creates two user managed identies, ACRPull and ACRPush, scoped at the ACR
  - Assign built-in ACR Roles: AcrPull AcrPush to the respective Roles

> IMPORTANT  
> Ensure your account used for deploying the terraform has sufficient rights to assign roles to identities  

  The template does not create the log analytics workspace    

## Main.tf file content
  Please replace the modules source and version with your relevant information  

  ```hcl
// Core modules

module "regions_master" {
  source  = "app.terraform.io/<ORGANIZATION>/regions-master/azurerm"
  version = "x.y.z"
  azure_region = var.location # example eu-west
}

module "base_tagging" {
  source  = "app.terraform.io/<ORGANIZATION>/base-tagging/azurerm"
  version = "x.y.z"
  environment = var.environment
  stack = var.stack
  spoc =  var.spoc
  change = var.change
  costcenter = var.costcenter
  owner = var.owner
}

// Resource Group
module "ressource" {
    source  = "app.terraform.io/<ORGANIZATION>/rg/azurerm"
    version = "x.y.z"
    environment = var.environment
    stack       = var.stack
    landing_zone_slug = var.landing_zone_slug
    default_tags      = module.base-tagging.base_tags
    location    = module.regions_master.location
    location_short  = module.regions_master.location_short
}

module "acr" {
  source  = "app.terraform.io/<your-organization>/regions-master/azurerm"
  version = "x.y.z"
  landing_zone_slug = var.landing_zone_slug
  environment = var.environment
  stack       = var.stack
  default_tags                  = module.base-tagging.base_tags
  location                      = module.regions_master.location
  location_short                = module.regions_master.location_short
  resource_group_name           = module.rg.resource_group_name
  
  diag_log_analytics_workspace_id = var.diag_log_analytics_workspace_id
  
  public_network_access_enabled = true
  enable_private_endpoint = false
  
  allowed_cidrs = [
    "1.1.1.1",
    "2.2.2.2",
    "3.3.3.3"
    ]
}