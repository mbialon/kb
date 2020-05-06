# Docker

## Attach without signal forwarding

```
docker attach --sig-proxy=false <CONTAINER-ID>
```

## Detach from container

```C-p C-q```

## Grep logs

```
docker logs 2>&1 | grep hello
```

## Assign IP address

```
docker network create --subnet=172.18.0.0/16 gophernet
docker run --net gophernet --ip 172.18.0.22 -it ubuntu bash
```

## Trouble running Docker

- https://github.com/docker/docker/issues/27426
- https://github.com/docker/docker/blob/master/contrib/check-config.sh

## Running dlv inside a docker container

> Alright, so you're running within a Docker container. Docker has security settings preventing ptrace(2) operations by default with in the container. Pass —security-opt=seccomp:unconfined to docker run when starting.

https://github.com/derekparker/delve/issues/515

## Running arm containers on Ubuntu

```
sudo apt install qemu qemu-user-static binfmt-support
sudo update-binfmts --enable qemu-arm
```

Mount =qemu-arm-static= binary inside the container.

```
docker run -it --rm -v /usr/bin/qemu-arm-static:/usr/bin/qemu-arm-static philipz/rpi-raspbian bash
```

## Docker Compose

https://docs.docker.com/compose/compose-file/

### Expose port

```
expose:
  - "CONTAINER"
```

### Publish port

```
ports:
  - "HOST:CONTAINER"
```

## Install packages via apt-get

```
DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    aufs-tools \
    automake \
    build-essential \
    curl \
    dpkg-sig \
    libcap-dev \
    libsqlite3-dev \
    mercurial \
    reprepro \
    ruby1.9.1 \
    ruby1.9.1-dev \
    s3cmd=1.1.* \
    && rm -rf /var/lib/apt/lists/*
```

https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#run
