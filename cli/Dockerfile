FROM centos:8

EXPOSE 5000

VOLUME /data
VOLUME /etc/zonemaster

RUN dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled powertools && \
    dnf --enablerepo=extras install -y epel-release && \
    dnf install -y  glibc-locale-source \
                    # Engine dependencies
                    cpanminus gcc libidn-devel openssl-devel perl-Clone perl-core perl-Devel-CheckLib perl-Email-Valid perl-File-ShareDir perl-File-Slurp perl-libintl perl-IO-Socket-INET6 perl-JSON-PP perl-List-MoreUtils perl-Module-Find perl-Moose perl-Net-IP perl-Pod-Coverage perl-Readonly perl-Test-Differences perl-Test-Exception perl-Test-Fatal perl-Test-Pod perl-Text-CSV perl-YAML \
                    # Cli dependencies
                    perl-JSON-XS perl-MooseX-Getopt && \
    cpanm -n Log::Any Log::Any::Adapter::Dispatch Locale::Msgfmt Module::Install Module::Install::XSUtil MooseX::Singleton Test::More Text::Reflow && \
    localedef -c -i da_DK -f UTF-8 da_DK.UTF-8 && \
    localedef -c -i fi_FI -f UTF-8 fi_FI.UTF-8 && \
    localedef -c -i fr_FR -f UTF-8 fr_FR.UTF-8 && \
    localedef -c -i nb_NO -f UTF-8 nb_NO.UTF-8 && \
    localedef -c -i sv_SE -f UTF-8 sv_SE.UTF-8 && \
    useradd -r -c "Zonemaster daemon user" -U zonemaster

RUN curl https://cpan.metacpan.org/authors/id/M/MI/MIKER/Net-Interface-1.016.tar.gz | tar xz -C /tmp && \
    cd /tmp/Net-Interface-1.016 && \
    ./configure && \
    perl -I. Makefile.PL && \
    make && \
    make install

RUN cpanm -n Zonemaster::LDNS Zonemaster::Engine Zonemaster::CLI

USER zonemaster:zonemaster

ENTRYPOINT [ "zonemaster-cli" ]

CMD [ "--help" ]
