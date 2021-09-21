# Traefik

## Proxy to a container with TLS

### docker-compose.yml

```
---
version: "2.4"

services:
  traefik:
    image: traefik:v2.5.2
    restart: unless-stopped
    command: >
      --entrypoints.web.address=:80
      --entrypoints.web.http.redirections.entryPoint.to=websecure
      --entrypoints.web.http.redirections.entryPoint.scheme=https
      --entrypoints.websecure.address=:443
      --certificatesresolvers.resolver.acme.email=hello@gofer.dev
      --certificatesresolvers.resolver.acme.storage=/data/acme.json
      --certificatesresolvers.resolver.acme.httpchallenge.entrypoint=web
      --providers.docker
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - "./data:/data"
    ports:
      - "80:80"
      - "443:443"

  grafana:
    image: grafana/grafana:8.1.2
    restart: unless-stopped
    volumes:
      - "./grafana:/var/lib/grafana"
    labels:
      - traefik.http.routers.grafana.rule=Host(`grafana.gofer.dev`)
      - traefik.http.routers.grafana.tls=true
      - traefik.http.routers.grafana.tls.certresolver=resolver
      - traefik.http.services.grafana.loadbalancer.server.port=3000
```

## Proxy to an external service with TLS

### docker-compose.yml

```
---
version: "2.4"

services:
  traefik:
    image: traefik:v2.5.2
    restart: unless-stopped
    command: >
      --entrypoints.web.address=:80
      --entrypoints.web.http.redirections.entryPoint.to=websecure
      --entrypoints.web.http.redirections.entryPoint.scheme=https
      --entrypoints.websecure.address=:443
      --certificatesresolvers.resolver.acme.email=hello@gofer.dev
      --certificatesresolvers.resolver.acme.storage=/data/acme.json
      --certificatesresolvers.resolver.acme.httpchallenge.entrypoint=web
      --providers.file.filename=/etc/traefik/config.yml
    volumes:
      - "./config.yml:/etc/traefik/config.yml"
      - "./data:/data"
    ports:
      - "80:80"
      - "443:443"
```

### config.yml

```
---
http:
  routers:
    grafana:
      service: grafana
      rule: Host(`grafana.gofer.dev`)
      tls:
        certResolver: resolver

  services:
    grafana:
      loadBalancer:
        servers:
          - url: "http://192.168.1.2:3000/"
```
