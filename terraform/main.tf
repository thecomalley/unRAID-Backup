module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["unRAID", "backup"]
}

locals {
  common_tags = {
    Service = "local.service_name"
    Owner   = "local.owner"
  }
}

resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name
  location = var.location
}