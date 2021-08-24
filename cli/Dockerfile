FROM debian:11-slim

EXPOSE 5000

VOLUME /data
VOLUME /etc/zonemaster

RUN useradd -r -c "Zonemaster user" -U zonemaster

RUN apt-get update && \
    # Engine
    apt-get install -y locales autoconf automake build-essential cpanminus libclone-perl libdevel-checklib-perl libemail-valid-perl libfile-sharedir-perl libfile-slurp-perl libidn11-dev libintl-perl libio-socket-inet6-perl libjson-pp-perl liblist-moreutils-perl liblocale-msgfmt-perl libmodule-find-perl libmodule-install-perl libmodule-install-xsutil-perl libmoose-perl libmoosex-singleton-perl libnet-ip-perl libpod-coverage-perl libreadonly-xs-perl libssl-dev libtest-differences-perl libtest-exception-perl libtest-fatal-perl libtest-pod-perl libtext-csv-perl libtool m4 \
    # Cli
    libmoosex-getopt-perl libtext-reflow-perl libmodule-install-perl libnet-interface-perl && \
    # Update locales
    perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen && \
    locale-gen && \
    # Install Zonemaster components
    cpanm -n Zonemaster::LDNS Zonemaster::Engine Zonemaster::CLI && \
    # Clean up
    apt-get autoremove -y --purge cpanminus build-essential automake autoconf libtool m4 libssl-dev && \
    rm -rf /var/lib/apt/lists/*


USER zonemaster:zonemaster

ENTRYPOINT [ "zonemaster-cli" ]

CMD [ "--help" ]
