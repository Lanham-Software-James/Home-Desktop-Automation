#!/bin/bash
tar -cvzf /var/spool/cron/system-files-backup.tar.gz /home/jlanham/*
tar -cvzf /var/spool/cron/system-settings-backup.tar.gz /home/jlanham/.config/*

source /root/automation/config/vars.txt

aws s3 cp /var/spool/cron/system-files-backup.tar.gz $fileslocation
aws s3 cp /var/spool/cron/system-settings-backup.tar.gz $settingslocation

rm -rf /var/spool/cron/system-files-backup.tar.gz
rm -rf /var/spool/cron/system-settings-backup.tar.gz

rtcwake -m no -l -t $(date +%s -d 'Sunday 00:00')
systemctl suspend
