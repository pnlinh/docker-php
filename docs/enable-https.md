# Adding support for HTTPS/SSL

> All the following instructions should be adapted to your personal needs

If your plan to work locally only, first generate your self-signed cert and key using [mkcert](https://github.com/FiloSottile/mkcert)

```shell
mkcert localhost
```

Then copy your cert files on build stage of your Dockerfile:

```Dockerfile
FROM pnlinh/laravel:php8.2

COPY localhost.pem /usr/local/share/ca-certificates/my-cert.crt
RUN cat /usr/local/share/ca-certificates/my-cert.crt >> /etc/ssl/certs/ca-certificates.crt

COPY localhost*.pem /etc/nginx/ssl/

EXPOSE 80 443

```

Edit your nginx.conf file.


```nginx
server {
    listen [::]:80 default_server;
    listen 80 default_server;
    server_name _;

    return 301 https://$host$request_uri;
}


server {
    listen [::]:443 ssl;
    listen 443 ssl;
    server_name _;
  
    ssl_certificate /etc/nginx/ssl/localhost.pem;
    ssl_certificate_key /etc/nginx/ssl/localhost-key.pem;

    # ... the rest here
}
```

If you use docker-compose here is an example:

```yaml
  app:
    build:
      context: .
      dockerfile: Dockerfile
    ports: 
      - "80:80"
      - "443:443"
    volumes:
      - ./:/var/www/html
      - ./nginx-ssl.conf:/etc/nginx/conf.d/default.conf
    # ...
```

Finally, rebuild and restart your docker/compose.
