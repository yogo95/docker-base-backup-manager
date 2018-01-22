#!/usr/bin/env sh

#
# Run multiple backups
#

if [ -z "$BM_CONFIG_PATH" ]; then
    echo "Define backup-manager configuration path : BM_CONFIG_PATH=/config"
    export BM_CONFIG_PATH=/config
fi

if [ -d $BM_CONFIG_PATH ] ; then
    for f in $(find $BM_CONFIG_PATH/ -type f -name '*.conf'); do
        echo "Run backup with configuration '$f'"
        backup-manager -c "$f"
        bm_exit_code=$?
        if [ $bm_exit_code -ne 0 ]; then
            echo "Failed backup '$f' exitCode=$bm_exit_code"
        fi
    done
else
    echo "backup-manager configuration directory '$BM_CONFIG_PATH' not found"
fi


