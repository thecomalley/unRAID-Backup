data "healthchecksio_channel" "signal" {
  kind = "signal"
}

data "healthchecksio_channel" "pushover" {
  kind = "po"
}

resource "healthchecksio_check" "appdata" {
  name     = "appdata-azure"
  desc     = "Monitors backups from unRAID/mnt/user/Backup/appdata to ${azurerm_storage_account.example.name}:appdata"
  schedule = "0,30 2 * * *"
  tags = [
    "terraform",
  ]

  channels = [
    data.healthchecksio_channel.signal.id,
    data.healthchecksio_channel.pushover.id,
  ]
}