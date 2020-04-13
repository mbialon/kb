# OpenSSL

## Generate self-signed certificate and key in one line

```
openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout server.key -out server.crt
```

## View certificate

```
openssl x509 -in foo.pem -noout -text
```
