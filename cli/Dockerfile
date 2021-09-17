FROM zonemaster/engine:alpine as build

RUN apk add --no-cache \
    # Compile-time dependencies
    build-base \
    make \
    perl-app-cpanminus \
    perl-dev \
    perl-doc \
    perl-module-install \
 && cpanm --notest --no-wget \
    MooseX::Getopt \
    Text::Reflow \
    Net::Interface

# Install Zonemaster components
RUN cpanm --verbose --notest --no-wget \
    Zonemaster::CLI

FROM zonemaster/engine:alpine

COPY --from=build /usr/local/bin/zonemaster-cli /usr/local/bin/zonemaster-cli
COPY --from=build /usr/local/lib/perl5/site_perl /usr/local/lib/perl5/site_perl
COPY --from=build /usr/local/share/perl5/site_perl /usr/local/share/perl5/site_perl

USER nobody:nogroup

ENTRYPOINT [ "zonemaster-cli" ]

CMD [ "--help" ]
