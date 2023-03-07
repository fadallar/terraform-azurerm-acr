# Basic Azure Container Registry

This is an example for setting-up a an Azure Container Registry

This examples creates
  - Sets the different Azure Region representation ( location, location_short, location_cli ...) --> module "regions_master"
  - Instanciates a map object with the common Tags ot be applied to all resources --> module "base_tagging"
  - A resource-group --> module "ressource" 
  - Creates a Premium Azure Container Registry with a secure configuration baseline
  - Enable ACR Zone redundancy
  - Creates a Geo_redundant ACR in a second region
  - Creates private endpoints for the Azure Container Registry in the primary and secondary regions
  - Set the default diagnostics settings (All Logs and metric) whith a Log Analytics workspace as destination 
  - Creates two user managed identies, ACRPull and ACR Push, scoped at the ACR
  - Assign built-in ACR Roles: AcrPull AcrPush to the respective Roles

> IMPORTANT  
> Ensure your account used for deploying the terraform has sufficient rights to assign roles to identities  
> 

  The template does not create the subnets for the primary and secondary regions
  The template does not create the private DNZ zone for the private endpoints  
  The template does not create the log analytics workspace    

## Main.tf file content
  Please replace the modules source and version with your relevant information  

  ```hcl
// Core modules

module "regions_master" {
  source  = "app.terraform.io/<ORGANIZATION>/regions-master/azurem"
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

module "resource_secondary" {
    source  = "app.terraform.io/<ORGANIZATION>/rg/azurerm"
    version = "x.y.z"
    environment = var.environment
    stack       = var.stack
    landing_zone_slug = var.landing_zone_slug
    default_tags      = module.base-tagging.base_tags
    location    = module.regions_secondary.location
    location_short  = module.regions_secondary.location_short
}


module "acr" {
  source  = "app.terraform.io/<ORGANIZATION>/regions-master/azurem"
  version = "x.y.z"
  landing_zone_slug = var.landing_zone_slug
  environment = var.environment
  stack       = var.stack
  default_tags                  = module.base-tagging.base_tags
  location                      = module.regions_master.location
  location_short                = module.regions_master.location_short
  resource_group_name           = module.rg.resource_group_name
  
  diag_log_analytics_workspace_id = ""    #### Log Analytics Workspace Resource Id
  zone_redundancy_enabled       = true

  georeplication_locations = {
     location =  module.regions_secondary.location
     zone_redundancy_enabled = true 
     regional_endpoint_enabled = true 
     tags = module.base-tagging.base_tags
  }
  
  // Private Endpoint Configuration info

  private_dns_zone_ids          = ""    ### Private DNS zone resource id for the ACR private link
  private_endpoint_subnet_id    = ""    ### Resource id of the subnet used by the ACR private endpoint

}
```