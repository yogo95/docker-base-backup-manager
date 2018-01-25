#!/usr/bin/env sh

# Fast way to run backup-manager
if [ -z "$BM_CRON_SCHEDULE" ]; then
    # Once a day
    BM_CRON_SCHEDULE="0 0 * * *"
fi

echo "$BM_CRON_SCHEDULE /usr/bin/bm-run-batch" > /tmp/bm-default-cron.conf
crontab -u root /tmp/bm-default-cron.conf
tmp_exit_code=$?
if [ $tmp_exit_code -ne 0 ]; then
    echo "Failed to install cron job exitCode=$tmp_exit_code"
    exit 1
fi

echo "Configure gpg"
import-gpg
tmp_exit_code=$?
if [ $tmp_exit_code -ne 0 ]; then
    echo "Failed to initialize gpg exitCode=$tmp_exit_code"
fi

exec run-cron
