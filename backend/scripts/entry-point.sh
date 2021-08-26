#!/bin/bash
set -xe

function wait_for_db {
    db_info=$(perl /scripts/get_db_info.pl)
    if [ -n "$db_info" ]; then
        echo "Waiting for database to be up"
        /scripts/wait-for $db_info
    fi
}

function run_agent_standalone {
    echo "Starting agent in standalone mode"
    zonemaster_backend_testagent --logfile=- foreground
}

function run_rpcapi {
    echo "Starting RPCAPI"
    starman --preload-app /usr/local/bin/zonemaster_backend_rpcapi.psgi
}

function bootstrap_db {
    perl /scripts/create_db_postgresql.pl
}

case "$1" in
    "rpcapi")
        wait_for_db
        run_rpcapi
        ;;
    "agent")
        wait_for_db
        run_agent_standalone
        ;;
    "bootstrap")
        wait_for_db
        bootstrap_db
        ;;
    *)
        exec $@
        ;;
esac
