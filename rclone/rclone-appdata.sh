#!/bin/sh

# Variables
PING_URL="https://hc-ping.com/bf0942b7-b8be-4dac-90e7-f350b257a708"

# tell healthchecks job started
curl -m 10 --retry 5 $PING_URL/start

# Copy the source to the destination. Doesn't transfer unchanged files. Doesn't delete files from the destination
msg=$(rclone copy /mnt/user/Backup/appdata azure-remote-backup:appdata --dry-run)
rclone_exit = $?

# tell healthchecks job completed
curl -m 10 --retry 5 --data-raw "$msg" $PING_URL/$?