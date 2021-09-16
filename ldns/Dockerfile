FROM debian:11-slim as build

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
    # LDNS
    autoconf \
    automake \
    build-essential \
    cpanminus \
    libdevel-checklib-perl \
    libidn11-dev \
    libmodule-install-perl \
    libmodule-install-xsutil-perl \
    libssl-dev \
    libtest-fatal-perl \
    libtool \
    m4 \
    # Clean up
 && rm -rf /var/lib/apt/lists/* \
    # Install Zonemaster components
 && cpanm -n \
    Zonemaster::LDNS

FROM debian:11-slim

COPY --from=build /usr/local/lib/x86_64-linux-gnu/perl /usr/local/lib/x86_64-linux-gnu/perl
COPY --from=build /usr/local/share/perl /usr/local/share/perl

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
    # LDNS
    libidn11 \
    # Clean up
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*
