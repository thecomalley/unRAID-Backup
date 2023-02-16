module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["unRAID", "backup"]
}

resource "azurerm_resource_group" "main" {
  name     = module.naming.resource_group.name
  location = var.location
}

resource "azurerm_storage_account" "main" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_container" "main" {
  name                  = "appdata"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "main" {
  storage_account_id = azurerm_storage_account.main.id
  rule {
    name    = "global-policy"
    enabled = true
    filters {
      prefix_match = ["*"]
      blob_types   = ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 30
        tier_to_archive_after_days_since_modification_greater_than = 60
        delete_after_days_since_modification_greater_than          = 120
      }
    }
  }
}