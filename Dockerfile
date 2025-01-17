FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -q -y update \
 && apt-get -q -y --no-install-recommends \
    -o "DPkg::Options::=--force-confold" \
    -o "DPkg::Options::=--force-confdef" \
    net-tools tzdata vim iputils-ping curl telnet apt-utils \
 && rm /etc/dpkg/dpkg.cfg.d/excludes \
 && apt-get -q -y --no-install-recommends \
    -o "DPkg::Options::=--force-confold" \
    -o "DPkg::Options::=--force-confdef" \
    install dumb-init isc-dhcp-server man \
 && apt-get -q -y autoremove \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*

COPY util/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
