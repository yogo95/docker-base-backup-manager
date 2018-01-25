#!/usr/bin/env sh

config_cron_dir_path=/config/cron

# Run cron
if [ -d "$config_cron_dir_path" ]; then
    echo "Found folder $config_cron_dir_path. Initialize cron"

    for f in $(find $config_cron_dir_path/ -type f -name '*.cron-init.sh'); do
        echo "Found initialize cron file script '$f'"
        sh $f
        script_exit_code=$?
        if [ $script_exit_code -ne 0 ]; then
            echo "Failed initialize cron from file '$f' exitCode=$script_exit_code"
            exit 1
        fi
    done
fi

if [ -z "$CRON_LOG_LEVEL" ]; then
    echo "Define CRON_LOG_LEVEL=8"
    export CRON_LOG_LEVEL=8
fi

echo "Start cron"
exec /usr/sbin/crond -f -d "$CRON_LOG_LEVEL"
