locals {
  default_tags = var.default_tags_enabled ? {
    Environment   = var.environment
    Application = var.stack
    CostCenter = var.costcenter
    Owner = var.owner
    SPOC = var.spoc
    Change = var.change
  } : {}
}
