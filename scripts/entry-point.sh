#!/bin/bash

function run_agent_daemon {
    echo "Starting agent in daemon mode"
    zonemaster_backend_testagent --logfile=- start
}

function run_agent_standalone {
    echo "Starting agent in standalone mode"
    zonemaster_backend_testagent --logfile=- foreground
}

function run_api {
    echo "Starting RPCAPI"
    starman --preload-app /usr/local/bin/zonemaster_backend_rpcapi.psgi
}

function bootstrap_db {
    perl /scripts/create_db_postgresql.pl
}

case "$1" in
    "all")
        run_agent_daemon
        run_api
        ;;
    "api")
        run_api
        ;;
    "agent")
        run_agent_standalone
        ;;
    "bootstrap")
        bootstrap_db
        ;;
    *)
        exec $@
        ;;
esac
