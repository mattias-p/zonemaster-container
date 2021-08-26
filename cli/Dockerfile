FROM debian:11-slim as build

RUN apt-get update && \
    apt-get upgrade -y && \
    # Engine
    apt-get install -y locales autoconf automake build-essential cpanminus libclone-perl libdevel-checklib-perl libemail-valid-perl libfile-sharedir-perl libfile-slurp-perl libidn11-dev libintl-perl libio-socket-inet6-perl libjson-pp-perl liblist-moreutils-perl liblocale-msgfmt-perl libmodule-find-perl libmodule-install-perl libmodule-install-xsutil-perl libmoose-perl libmoosex-singleton-perl libnet-ip-perl libpod-coverage-perl libreadonly-xs-perl libssl-dev libtest-differences-perl libtest-exception-perl libtest-fatal-perl libtest-pod-perl libtext-csv-perl libtool m4 \
    # Cli
    libmoosex-getopt-perl libtext-reflow-perl libmodule-install-perl libnet-interface-perl && \
    # Clean up
    rm -rf /var/lib/apt/lists/* && \
    # Install Zonemaster components
    cpanm -n Zonemaster::LDNS Zonemaster::Engine Zonemaster::CLI

FROM debian:11-slim

COPY --from=build /usr/local/bin/zonemaster-cli /usr/local/bin/zonemaster-cli
COPY --from=build /usr/local/lib/x86_64-linux-gnu/perl /usr/local/lib/x86_64-linux-gnu/perl
COPY --from=build /usr/local/share/perl /usr/local/share/perl

RUN apt-get update && \
    apt-get upgrade -y && \
    # Engine
    apt-get install -y locales libclone-perl libemail-valid-perl libfile-sharedir-perl libfile-slurp-perl libidn11 libintl-perl libio-socket-inet6-perl libjson-pp-perl liblist-moreutils-perl libmodule-find-perl libmoose-perl libmoosex-singleton-perl libnet-ip-perl libreadonly-xs-perl libtext-csv-perl \
    # Cli
    libmoosex-getopt-perl libtext-reflow-perl libnet-interface-perl && \
    # Clean up
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    # Update locales
    perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen && \
    locale-gen

USER nobody:nogroup

ENTRYPOINT [ "zonemaster-cli" ]

CMD [ "--help" ]
