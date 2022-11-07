# Docker PHP-FPM & Nginx base on Alpine Linux

Simple docker image for Symfony development

- Magento: https://github.com/pnlinh/docker-php/tree/feature/magento
- PHP/Laravel: https://github.com/pnlinh/docker-php

### How to use

- Build image

```shell
./build php7.2 # Build image with php 7.2
./build php7.4 # Build image with php 7.4
./build php8.0 # Build image with php 8.0
./build php8.1 # Build image with php 8.1
```

- Build for Symfony 3 with PHP 7.4

```shell
docker build --no-cache -f php7.4.symfony-3.Dockerfile . -t pnlinh/symfony-3:php7.4
```

- Mount your code to be served with container

```shell
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/symfony:php8.1
```

- With docker-compose

```
version: '3.4'

services:
    app:
        image: pnlinh/symfony:php8.1
        hostname: symfony-app
        container_name: symfony-app
        ports:
            - "80:80"
        volumes:
            - .:/var/www/html
        networks:
            - localnet
            
networks:
    localnet:
        driver: "bridge"
```

- Browser to: [http://localhost](http://localhost)

![image](https://user-images.githubusercontent.com/26193890/198827932-7901d969-cf9c-4f2a-8154-e2b1fb4840f8.png)

### References

- https://github.com/TrafeX/docker-php-nginx
