FROM alpine:3.7

LABEL maintainer="NEGRO Y CASTRO, Eric <yogo95@zrim-everythng.eu>"

ARG BACKUPMANAGER_VERSION=0.7.13

RUN BUILD_DEPS=" \
    build-base \
    git \
    libtool \
    automake \
    autoconf \
    wget \
    subversion \
    cppunit-dev \
    openssl \
    ncurses-dev \
    curl-dev" \
 && apk -U add \
    ${BUILD_DEPS} \
    coreutils \
    binutils \
    bash \
    curl \
    perl \
    tar \
    bzip2 \
    gzip \
    gnupg \
    gettext \
    mysql-client \
    postgresql \
    ca-certificates \
 && wget https://github.com/sukria/Backup-Manager/archive/${BACKUPMANAGER_VERSION}.zip -O /tmp/backup-manager.zip \
 && unzip /tmp/backup-manager.zip -d /tmp/ \
 && cd /tmp/Backup-Manager-${BACKUPMANAGER_VERSION} \
 && make install \
 && apk del ${BUILD_DEPS} \
 && rm -rf /var/cache/apk/* /tmp/*

# Copy scripts
COPY scripts/import-gpg.sh /usr/bin/import-gpg
COPY scripts/bm-run-batch.sh /usr/bin/bm-run-batch
COPY scripts/run-cron.sh /usr/bin/run-cron
COPY scripts/bm-run-as-cron.sh /usr/bin/bm-run-as-cron

RUN chmod +x /usr/bin/import-gpg /usr/bin/bm-run-batch /usr/bin/run-cron /usr/bin/bm-run-as-cron

CMD ["/usr/bin/bm-run-as-cron"]
