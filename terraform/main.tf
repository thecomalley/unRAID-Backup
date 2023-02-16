module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["unRAID", "backup"]
}

locals {
  common_tags = {
    application = "unRAID-backup"
    enviroment  = "production"
    deployment  = "terraform"
  }
}

resource "azurerm_resource_group" "example" {
  name     = module.naming.resource_group.name
  location = var.location
  tags = merge(local.common_tags, {
    yor_trace = "fd7d90bf-3fa5-4025-8908-c7c4341fc2d2"
  })
}

resource "template_dir" "config" {
  source_dir      = "../rclone/templates"
  destination_dir = "../rclone/user_scripts"

  vars = {
    ping_url           = "${healthchecksio_check.appdata.ping_url}"
    storage_account    = "${azurerm_storage_account.example.name}"
    primary_access_key = "${azurerm_storage_account.example.primary_access_key}"
  }
}