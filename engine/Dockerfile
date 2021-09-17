FROM zonemaster/ldns:alpine as build

RUN apk add --no-cache \
    # Compile-time dependencies
    build-base \
    make \
    perl-app-cpanminus \
    perl-clone \
    perl-dev \
    perl-file-sharedir \
    perl-file-slurp \
    perl-io-socket-inet6 \
    perl-list-moreutils \
    perl-locale-msgfmt \
    perl-module-install \
    perl-moose \
    perl-net-ip \
    perl-pod-coverage \
    perl-test-differences \
    perl-test-exception \
    perl-test-fatal \
    perl-test-pod \
    perl-text-csv \
 && cpanm --notest --no-wget \
    Email::Valid \
    Locale::TextDomain \
    JSON::PP \
    Module::Find \
    MooseX::Singleton \
    Readonly::XS

RUN cpanm --notest --no-wget \
    # Install Zonemaster components
    Zonemaster::Engine

FROM zonemaster/ldns:alpine

COPY --from=build /usr/local/lib/perl5/site_perl /usr/local/lib/perl5/site_perl

RUN apk add --no-cache \
    # Run-time dependencies
    musl-locales \
    perl-clone \
    perl-file-sharedir \
    perl-file-slurp \
    perl-io-socket-inet6 \
    perl-list-moreutils \
    perl-locale-msgfmt \
    perl-module-install \
    perl-moose \
    perl-net-ip \
    perl-text-csv
