FROM centos:8

VOLUME /data

RUN dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled powertools && \
    dnf --enablerepo=extras install -y epel-release && \
    dnf install -y  glibc-locale-source \
                    # Engine dependencies
                    cpanminus gcc libidn-devel openssl-devel perl-Clone perl-core perl-Devel-CheckLib perl-Email-Valid perl-File-ShareDir perl-File-Slurp perl-libintl perl-IO-Socket-INET6 perl-JSON-PP perl-List-MoreUtils perl-Module-Find perl-Moose perl-Net-IP perl-Pod-Coverage perl-Readonly perl-Test-Differences perl-Test-Exception perl-Test-Fatal perl-Test-Pod perl-Text-CSV perl-YAML \
                    # Backend dependencies
                    jq perl-Class-Method-Modifiers perl-Config-IniFiles perl-DBD-SQLite perl-DBI perl-HTML-Parser perl-JSON-RPC perl-libwww-perl perl-Log-Dispatch perl-Net-Server perl-Parallel-ForkManager perl-Plack perl-Plack-Test perl-Role-Tiny perl-Router-Simple perl-String-ShellQuote perl-Test-NoWarnings perl-Test-Warn perl-Try-Tiny redhat-lsb-core \
                    # DB
                    perl-DBD-Pg perl-DBD-mysql && \
    cpanm -n Daemon::Control JSON::Validator Log::Any Log::Any::Adapter::Dispatch Starman \
             Locale::Msgfmt Module::Install Module::Install::XSUtil MooseX::Singleton Test::More && \
    localedef -c -i da_DK -f UTF-8 da_DK.UTF-8 && \
    localedef -c -i fi_FI -f UTF-8 fi_FI.UTF-8 && \
    localedef -c -i fr_FR -f UTF-8 fr_FR.UTF-8 && \
    localedef -c -i nb_NO -f UTF-8 nb_NO.UTF-8 && \
    localedef -c -i sv_SE -f UTF-8 sv_SE.UTF-8 && \
    useradd -r -c "Zonemaster daemon user" -U zonemaster && \
    mkdir /scripts

COPY /scripts/* /scripts

# TODO: Change this to the single script coming in next version
RUN curl -L https://raw.githubusercontent.com/zonemaster/zonemaster-backend/master/script/create_db_postgresql_9.3.pl -o /scripts/create_db_postgresql.pl

RUN chmod +x /scripts/*

RUN cpanm -n Zonemaster::LDNS Zonemaster::Engine Zonemaster::Backend

USER zonemaster:zonemaster

ENTRYPOINT [ "/scripts/entry-point.sh" ]

CMD [ "all" ]
