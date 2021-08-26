FROM debian:11-slim as build

RUN apt-get update && \
    apt-get upgrade -y && \
    # Engine
    apt-get install -y locales autoconf automake build-essential cpanminus libclone-perl libdevel-checklib-perl libemail-valid-perl libfile-sharedir-perl libfile-slurp-perl libidn11-dev libintl-perl libio-socket-inet6-perl libjson-pp-perl liblist-moreutils-perl liblocale-msgfmt-perl libmodule-find-perl libmodule-install-perl libmodule-install-xsutil-perl libmoose-perl libmoosex-singleton-perl libnet-ip-perl libpod-coverage-perl libreadonly-xs-perl libssl-dev libtext-csv-perl libtool m4 \
    # Backend
    libclass-method-modifiers-perl libconfig-inifiles-perl libdbd-sqlite3-perl libdbi-perl libfile-sharedir-perl libfile-slurp-perl libhtml-parser-perl libio-stringy-perl libjson-pp-perl libjson-rpc-perl liblog-any-adapter-dispatch-perl liblog-any-perl liblog-dispatch-perl libmoose-perl libparallel-forkmanager-perl libplack-perl libplack-middleware-debug-perl librole-tiny-perl librouter-simple-perl libstring-shellquote-perl libtry-tiny-perl starman libdaemon-control-perl libjson-validator-perl \
    # Build deps
    curl && \
    # Clean up
    rm -rf /var/lib/apt/lists/* && \
    # Install zonemaster components
    cpanm -n Zonemaster::LDNS Zonemaster::Engine Zonemaster::Backend

COPY ./scripts /scripts

# TODO: Change this to the single script coming in next version
RUN curl -L https://raw.githubusercontent.com/zonemaster/zonemaster-backend/master/script/create_db_postgresql_9.3.pl -o /scripts/create_db_postgresql.pl && \
    curl -L https://github.com/eficode/wait-for/releases/download/v2.1.3/wait-for -o /scripts/wait-for && \
    chmod +x /scripts/wait-for

FROM debian:11-slim

COPY --from=build /scripts /scripts
COPY --from=build /usr/local/bin/zonemaster_backend_rpcapi.psgi /usr/local/bin/
COPY --from=build /usr/local/bin/zonemaster_backend_testagent /usr/local/bin/
COPY --from=build /usr/local/lib/x86_64-linux-gnu/perl /usr/local/lib/x86_64-linux-gnu/perl
COPY --from=build /usr/local/share/perl /usr/local/share/perl

RUN apt-get update && \
    apt-get upgrade -y && \
    # Engine
    apt-get install -y locales libclone-perl libemail-valid-perl libfile-sharedir-perl libfile-slurp-perl libidn11 libintl-perl libio-socket-inet6-perl libjson-pp-perl liblist-moreutils-perl libmodule-find-perl libmoose-perl libmoosex-singleton-perl libnet-ip-perl libreadonly-xs-perl libtext-csv-perl \
    # Backend
    libclass-method-modifiers-perl libconfig-inifiles-perl libdbd-sqlite3-perl libdbi-perl libfile-sharedir-perl libfile-slurp-perl libhtml-parser-perl libio-stringy-perl libjson-pp-perl libjson-rpc-perl liblog-any-adapter-dispatch-perl liblog-any-perl liblog-dispatch-perl libmoose-perl libparallel-forkmanager-perl libplack-perl libplack-middleware-debug-perl librole-tiny-perl librouter-simple-perl libstring-shellquote-perl libtry-tiny-perl starman libdaemon-control-perl libjson-validator-perl \
    # DB
    libdbd-pg-perl \
    # wait-for
    netcat && \
    # Clean up
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    # Update locales
    perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen && \
    locale-gen && \
    # Daemon user
    useradd -r -c "Zonemaster user" -U zonemaster

EXPOSE 5000

VOLUME /data
VOLUME /etc/zonemaster

USER zonemaster:zonemaster

ENTRYPOINT [ "/scripts/entry-point.sh" ]

CMD [ "all" ]
