# Docker PHP-FPM & Nginx base on Alpine Linux

Simple docker image for PHP/Laravel development

- Magento: https://github.com/pnlinh/docker-php/tree/feature/magento
- Symfony: https://github.com/pnlinh/docker-php/tree/feature/symfony

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
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/laravel:php8.1
```

- With docker-compose

```
version: '3.4'

services:
    app:
        image: pnlinh/laravel:php8.1
        hostname: laravel-app
        container_name: laravel-app
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

![image](https://user-images.githubusercontent.com/26193890/198828634-fc11aaa1-7175-4433-b4f3-755381669e74.png)

### References

- https://github.com/TrafeX/docker-php-nginx
