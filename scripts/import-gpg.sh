#!/usr/bin/env sh

if [ -z "$GPG_REPOSITORY" ]; then
    export GPG_REPOSITORY=/config
fi

if [ -d $GPG_REPOSITORY ] ; then
    for f in $(find $GPG_REPOSITORY/ -type f -name '*.gpg'); do
        echo "Import gpg key ${f}"
        gpg --import ${f}
    done
else
    echo "gpg repository '$GPG_REPOSITORY' not found"
fi

if [ -n "$GPG_RECIPIENT" ]; then
    gpg --list-keys -r ${GPG_RECIPIENT} --fingerprint --with-colons \
    | sed -E -n -e 's/^fpr:::::::::([0-9A-F]+):$/\1:6:/p' \
    | gpg --import-ownertrust
fi
