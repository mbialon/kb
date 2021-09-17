# Traefik

## Proxy to external service with TLS

!!! example "docker-compose.yml"
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

!!! example "config.yml"
    ```
    ---
    http:
      routers:
        grafana:
          service: grafana
          rule: Host(`grafana.gofer.dev
          tls:
            certResolver: resolver

      services:
        grafana:
          loadBalancer:
            servers:
              - url: "http://192.168.1.2:3000/"
    ```
