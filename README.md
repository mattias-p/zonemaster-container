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

The Zonemaster GUI can be accessed on port 8080, while the RPC API is available
on port 5000 if you prefer to use it directly. Note that the API is also
available on 8080 using the `/api` route, e.g. `http://localhost:8080/api`

You can customize your installation by editing the configuration at
`./config/backend_config.ini`.

The `./config` directory is mounted read-only as `/etc/zonemaster` inside the
container so you can create new profiles in this directory.


## Troubleshouting

* To make IPv6 tests work correctly make sure to enable IPv6 on your container
  runtime, instruction for Docker: <https://docs.docker.com/config/daemon/ipv6/>.
