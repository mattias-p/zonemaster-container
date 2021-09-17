FROM alpine:3.14 as build

RUN apk add --no-cache \
    # Compile-time dependencies
    autoconf \
    automake \
    build-base \
    perl-dev \
    libidn-dev \
    libtool \
    make \
    openssl-dev \
    perl-app-cpanminus \
    perl-devel-checklib \
    perl-module-install \
    perl-test-fatal \
 && cpanm --notest --no-wget \
    Module::Install::XSUtil

RUN cpanm --notest --no-wget \
    # Zonemaster components
    Zonemaster::LDNS

FROM alpine:3.14

COPY --from=build /usr/local/lib/perl5/site_perl/auto/Zonemaster /usr/local/lib/perl5/site_perl/auto/Zonemaster
COPY --from=build /usr/local/lib/perl5/site_perl/Zonemaster /usr/local/lib/perl5/site_perl/Zonemaster

RUN apk add --no-cache \
    # Run-time dependencies
    libidn
