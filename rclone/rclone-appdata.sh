#!/bin/sh

# tell healthchecks job started
curl -m 10 --retry 5 https://hc-ping.com/eb095278-f28d-448d-87fb-7b75c171a6aa/start

# Copy the source to the destination. Doesn't transfer unchanged files. Doesn't delete files from the destination
rclone copy /mnt/user/Backup/appdata azure-remote-backup:appdata --dry-run

# tell healthchecks job completed
curl -m 10 --retry 5 https://hc-ping.com/eb095278-f28d-448d-87fb-7b75c171a6aa