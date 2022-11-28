# Docker PHP-FPM & Nginx base on Alpine Linux

Simple docker image for Magento development

### Why should use this image

- Built on the lightweight and
  secure [Alpine Linux](https://www.alpinelinux.org/) distribution
- Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
- Use [runit](http://smarden.org/runit/) instead
  of [supervisor](http://supervisord.org/)
- Very small Docker image size

### PHP version support

- [x] PHP 7.2
- [x] PHP 7.4
- [x] PHP 8.0
- [x] PHP 8.1 (recommend usage)
- [ ] PHP 8.2 (todo)

### How to use

- Build image

```shell
./build php7.2 # Build image with php 7.2
./build php7.4 # Build image with php 7.4
./build php8.0 # Build image with php 8.0
./build php8.1 # Build image with php 8.1
```

- Mount your code to be served with container

```shell
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/magento:php7.4
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/magento:php8.0
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/magento:php8.1
```

- With docker-compose

```
version: '3.4'

services:
    app:
        image: pnlinh/magento:php8.1
        hostname: magento-app
        container_name: magento-app
        ports:
            - "80:80"
        volumes:
            - .:/var/www/html
        networks:
            - localnet
```

- See PHP version info

```shell
docker run --name=app --rm -p 80:80 pnlinh/magento:php7.4
docker run --name=app --rm -p 80:80 pnlinh/magento:php8.0
docker run --name=app --rm -p 80:80 pnlinh/magento:php8.1
```

![image](https://user-images.githubusercontent.com/26193890/164198187-743e3585-1379-4d06-a2d5-34330b17d060.png)

### Useful images

- PHP/Laravel: https://github.com/pnlinh/docker-php
- Symfony: https://github.com/pnlinh/docker-php/tree/feature/symfony

### References

- https://github.com/TrafeX/docker-php-nginx
- https://bolshov.online/docker/2020/11/18/runit-vs-supervisor
