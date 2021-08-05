# Zonemaster Container

> Only PostgreSQL database backend is supported by the bootstrap script at the moment.

## Usage

To use the docker-compose, execute the following commands inside this Git repository.

```sh
# Bootstrap the database
% docker-compose up --build bootstrap
# Run start zonemaster
% docker-compose up -d
```

The Zonemaster RPC API will be available on the port 5000.

You can customize your installation by editing the configuration at `./config/backend_config.ini`.

The `./config` directory is mounted read-only as `/etc/zonemaster` inside the
container so you can create new profiles in this directory.
