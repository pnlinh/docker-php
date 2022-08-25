# Docker PHP-FPM & Nginx base on Alpine Linux

Simple docker image for PHP development

### How to use

- First, build image

```shell
./build 74 # Build docker php image for php 7.4
./build 80 # Build docker php image for php 8.0
./build 81 # Build docker php image for php 8.1
```

- Mount your code to be served with container

```shell
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/php:74
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/php:80
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/php:81
```

- See PHP version info

```shell
docker run --name=app --rm -p 80:80 pnlinh/php:74
docker run --name=app --rm -p 80:80 pnlinh/php:80
docker run --name=app --rm -p 80:80 pnlinh/php:81
```

![image](https://user-images.githubusercontent.com/26193890/164198187-743e3585-1379-4d06-a2d5-34330b17d060.png)

###  References
 - https://github.com/TrafeX/docker-php-nginx
