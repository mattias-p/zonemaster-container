FROM localhost:5001/zonemaster/engine as build

RUN apt-get update \
 && apt-get install -y \
    cpanminus \
    # Cli
    libmodule-install-perl \
    libmoosex-getopt-perl \
    libnet-interface-perl \
    libtext-reflow-perl \
    # Clean up
 && rm -rf /var/lib/apt/lists/* \
    # Install Zonemaster components
 && cpanm -n \
    Zonemaster::CLI

FROM localhost:5001/zonemaster/engine

COPY --from=build /usr/local/bin/zonemaster-cli /usr/local/bin/zonemaster-cli

RUN apt-get update \
 && apt-get install -y \
    # Cli
    libmoosex-getopt-perl \
    libnet-interface-perl \
    libtext-reflow-perl \
    # Clean up
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

USER nobody:nogroup

ENTRYPOINT [ "zonemaster-cli" ]

CMD [ "--help" ]
