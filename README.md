# unraid-Backup
Backup on-prem data (unRAID) to remote server (Azure Storage) & monitor via Healthchecks.io

## Requirements
- unRAID
  - plugin: user scripts
  - plugin: rclone

## Usage
1. Provision infrastrucure via terraform
2. Upload rsync config and scripts to unRAID server
   1. Add the contents of `rclone.config.tpl` to `/boot/config/plugins/rclone/.rclone.conf`
   2. Add the contents of `rclone-appdata.tpl` to `/boot/config/plugins/user.scripts/scripts/rclone-appdata.sh`

## Terraform Docs
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
