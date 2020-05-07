# Caddy

Put docs into `/var/www/docs/prefix`.

Add the snippet to config.

```
docs.example.com/prefix/* {
	root * /var/www/docs
	file_server
}
```