FROM localhost:5001/zonemaster/ldns as build

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
    # Engine
    cpanminus \
    libclone-perl \
    libemail-valid-perl \
    libfile-sharedir-perl \
    libfile-slurp-perl \
    libintl-perl \
    libio-socket-inet6-perl \
    libjson-pp-perl \
    liblist-moreutils-perl \
    liblocale-msgfmt-perl \
    libmodule-find-perl \
    libmodule-install-perl \
    libmoose-perl \
    libmoosex-singleton-perl \
    libnet-ip-perl \
    libpod-coverage-perl \
    libreadonly-xs-perl \
    libtest-differences-perl \
    libtest-exception-perl \
    libtest-fatal-perl \
    libtest-pod-perl \
    libtext-csv-perl \
    libtool \
    locales \
    # Clean up
 && rm -rf /var/lib/apt/lists/* \
    # Install Zonemaster components
 && cpanm -n \
    Zonemaster::Engine

FROM localhost:5001/zonemaster/ldns

COPY --from=build /usr/local/share/perl /usr/local/share/perl

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
    # Engine
    libclone-perl \
    libemail-valid-perl \
    libfile-sharedir-perl \
    libfile-slurp-perl \
    libidn11 \
    libintl-perl \
    libio-socket-inet6-perl \
    libjson-pp-perl \
    liblist-moreutils-perl \
    libmodule-find-perl \
    libmoose-perl \
    libmoosex-singleton-perl \
    libnet-ip-perl \
    libreadonly-xs-perl \
    libtext-csv-perl \
    locales \
    # Clean up
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/* \
    # Update locales
 && perl -pi -e 's/^# (da_DK\.UTF-8.*|en_US\.UTF-8.*|fi_FI\.UTF-8.*|fr_FR\.UTF-8.*|nb_NO\.UTF-8.*|sv_SE\.UTF-8.*)/$1/' /etc/locale.gen \
 && locale-gen
