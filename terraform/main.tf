locals {
  containers = [
    "appdata",
  ]
}

resource "azurerm_resource_group" "main" {
  name     = "oma-unRAID-backup-rg"
  location = var.location
  tags = {
    git_commit           = "2fb5b93159f4b3328d85b78efa2c677ed5d9ad85"
    git_file             = "terraform/main.tf"
    git_last_modified_at = "2023-02-16 21:06:34"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "unraid-Backup"
    yor_trace            = "08bea4dd-4223-4567-946f-01ca6ed4dc77"
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "omaunraidbackupst"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"

  identity {
    type = "SystemAssigned"
  }

  allow_nested_items_to_be_public = false
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true

  network_rules {
    default_action = "Deny"
    ip_rules = [
      var.white_list_ip,
    ]
  }

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }

  tags = {
    git_commit           = "2fb5b93159f4b3328d85b78efa2c677ed5d9ad85"
    git_file             = "terraform/main.tf"
    git_last_modified_at = "2023-02-16 21:06:34"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "unraid-Backup"
    yor_trace            = "cae566fb-accd-4d2a-bdbb-6d33979fb92d"
  }
}

resource "azurerm_storage_container" "main" {
  for_each = toset(local.containers)

  name                  = each.value
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


resource "azurerm_log_analytics_workspace" "main" {
  name                = "oma-unRAID-backup-la"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    git_commit           = "2fb5b93159f4b3328d85b78efa2c677ed5d9ad85"
    git_file             = "terraform/main.tf"
    git_last_modified_at = "2023-02-16 21:06:34"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "unraid-Backup"
    yor_trace            = "77a19b3b-8c5d-4ed5-bdf4-93376805ab91"
  }
}

resource "azurerm_log_analytics_storage_insights" "main" {
  name                = "storage-insights"
  resource_group_name = azurerm_resource_group.main.name
  workspace_id        = azurerm_log_analytics_workspace.main.id

  storage_account_id   = azurerm_storage_account.main.id
  storage_account_key  = azurerm_storage_account.main.primary_access_key
  blob_container_names = ["blobExample_ok"]
  tags = {
    git_commit           = "2fb5b93159f4b3328d85b78efa2c677ed5d9ad85"
    git_file             = "terraform/main.tf"
    git_last_modified_at = "2023-02-16 21:06:34"
    git_last_modified_by = "31399219+thecomalley@users.noreply.github.com"
    git_modifiers        = "31399219+thecomalley"
    git_org              = "thecomalley"
    git_repo             = "unraid-Backup"
    yor_trace            = "8d98142e-fa9f-490d-a8f7-7e8e4bb4daac"
  }
}