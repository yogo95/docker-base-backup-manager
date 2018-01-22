# Base Backup Manager docker image

## Introduction

Contains a base image of backup-manger.

Inspired from [https://github.com/flip-bs/docker-backup-manager](https://github.com/flip-bs/docker-backup-manager)

## Scripts

### Import gpg keys

Use the script `import-gpg` to import keys.

Use the environment variable `GPG_REPOSITORY` to define the directory where to find keys.

Use the environment variable `GPG_RECIPIENT` to specify the trusted recipient.

### Run Backup-Manager batch

Use the script `bm-run-batch` to execute multiple backups.

Use the environment variable `BM_CONFIG_PATH` to specify the directory where
to find the configuration with the extension `conf`.
