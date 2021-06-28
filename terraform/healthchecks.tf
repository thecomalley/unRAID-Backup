data "healthchecksio_channel" "pushover" {
  kind = "pushover"
}

resource "healthchecksio_check" "appdata" {
  name     = "appdata-azure"
  desc     = "Monitors backup from unRAID/mnt/user/Backup/appdata to ${azurerm_storage_account.example.name}:appdata"
  channels = data.healthchecksio_channel.pushover.id
}