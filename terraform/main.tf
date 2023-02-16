module "naming" {
  source = "Azure/naming/azurerm"
  suffix = ["unRAID", "backup"]
}

resource "azurerm_resource_group" "main" {
  name     = module.naming.resource_group.name
  location = var.location
  tags = {
    git_commit           = "fd19843a1da521c7c41fbab2aee415d83bcf73f4"
    git_file             = "terraform/main.tf"
    git_last_modified_at = "2023-02-16 20:49:14"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "unraid-Backup"
    yor_trace            = "08bea4dd-4223-4567-946f-01ca6ed4dc77"
  }
}

resource "azurerm_storage_account" "main" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    git_commit           = "fd19843a1da521c7c41fbab2aee415d83bcf73f4"
    git_file             = "terraform/main.tf"
    git_last_modified_at = "2023-02-16 20:49:14"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "unraid-Backup"
    yor_trace            = "cae566fb-accd-4d2a-bdbb-6d33979fb92d"
  }
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