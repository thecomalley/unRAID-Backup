# unraid-Backup
Backup on-prem data (unRAID) to remote server (Azure Storage) & monitor via Healthchecks.io

## Requirements
- unRAID Plugins
  - [CA APPDATA BACKUP / RESTORE V3](https://forums.unraid.net/topic/132721-plugin-ca-appdata-backup-restore-v3)
  - [rclone](https://forums.unraid.net/topic/51633-plugin-rclone/)

## Deployment Steps
1. Deploy terraform stack, this repo uses Terraform Cloud
2. unRAID config
   1. Edit rsync config under rclone settings
   2. 

3. Upload rsync config and scripts to unRAID server
   1. Add the contents of `rclone.config.tpl` to `/boot/config/plugins/rclone/.rclone.conf`
   2. Add the contents of `rclone-appdata.tpl` to `/boot/config/plugins/user.scripts/scripts/rclone-appdata.sh`

## Terraform Docs
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
