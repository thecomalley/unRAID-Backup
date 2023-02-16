# unRAID-Backup
Backup on-prem data (unRAID) to remote server (Azure Storage) & monitor via Healthchecks.io

## Requirements
- unRAID Plugins
  - [CA APPDATA BACKUP / RESTORE V3](https://forums.unraid.net/topic/132721-plugin-ca-appdata-backup-restore-v3)
  - [rclone](https://forums.unraid.net/topic/51633-plugin-rclone/)

## Deployment Steps
1. Deploy terraform stack, this repo uses Terraform Cloud
2. unRAID config
   1. Copy the contents of `UserScripts/rclone.conf` to the rclone config in the unRAID settings GUI, replacing the variables with the values from the terraform output
   2. Copy the contents of `UserScripts/rclone-appdata.sh` to the rclone-appdata script in the unRAID settings GUI, again replacing the variables with the values from the terraform output
3. Test the backup by running the rclone-appdata script in the unRAID settings GUI