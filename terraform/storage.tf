resource "azurerm_storage_account" "example" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = merge(local.common_tags, {
    yor_trace = "f26b0a36-8e3e-427d-8526-6409862ceaa7"
    }, {
    git_commit           = "0879e5f930fb37e329cbe2536e368df32c2bc9f5"
    git_file             = "terraform/storage.tf"
    git_last_modified_at = "2021-06-28 16:37:17"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "unraid-Backup"
  })
}

resource "azurerm_storage_container" "example" {
  name                  = "appdata"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "example" {
  storage_account_id = azurerm_storage_account.example.id
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