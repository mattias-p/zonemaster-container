# Zonemaster Container

> Only PostgreSQL database backend is supported by the bootstrap script at the moment.

## Usage

### Docker Compose

#### GUI and API
To use the docker-compose, execute the following commands inside this Git repository.

```sh
# Bootstrap the database
% docker-compose up --build bootstrap
# Run start zonemaster
% docker-compose up -d
```

The Zonemaster GUI can be accessed on port 8080, while the RPC API is available
on port 5000 if you prefer to use it directly. Note that the API is also
available on port 8080 using the `/api` route, e.g. `http://localhost:8080/api`

#### CLI

To run the cli from the docker-compose use,
```sh
% docker-compose run --rm zonemaster-cli --help
```

#### Configuration

You can customize the backend settings by editing the configuration at
`./backend.conf.d/backend_config.ini`.

The `./backend.conf.d` directory is mounted read-only as `/etc/zonemaster`
inside the container so you can create new profiles in this directory.

The GUI configuration is available at `gui.conf.d/app.config.json`.


### Using the images

Building the images

```sh
% docker build -t zonemaster-backend ./backend
% docker build -t zonemaster-gui ./gui
% docker build -t zonemaster-cli ./cli
```

Running the CLI

```bash
% docker run --rm zonemaster-cli example.com

# Or using an alias
% alias zonemaster-cli='docker run --rm zonemaster-cli'
% zonemaster-cli example.com
```

Setting up the database for the backend

```sh
% docker run -v $PWD/backend.conf.d:/etc/zonemaster:ro zonemaster-backend bootstrap
```

Running the RPCAPI

```sh
% docker run -v $PWD/backend.conf.d:/etc/zonemaster:ro -p 5000:5000 zonemaster-backend rpcapi
```

Running an agent

```sh
% docker run -v $PWD/backend.conf.d:/etc/zonemaster:ro zonemaster-backend agent
```

Running the GUI

```sh
% docker run -v $PWD/gui.conf.d:/config:ro -e ZONEMASTER_API_ENDPOINT=http://example.com:5000 -p 8080:80 zonemaster-gui
```


## Troubleshouting

* To make IPv6 tests work correctly make sure to enable IPv6 on your container
  runtime, instruction for Docker: <https://docs.docker.com/config/daemon/ipv6/>.
