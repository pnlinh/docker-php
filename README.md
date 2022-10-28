# Docker PHP-FPM & Nginx base on Alpine Linux

Simple docker image for PHP/Laravel development

### How to use

- Build image

```shell
./build php7.2 # Build image with php 7.4
./build php7.4 # Build image with php 7.4
./build php8.0 # Build image with php 8.0
./build php8.1 # Build image with php 8.1
```

- Mount your code to be served with container

```shell
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/laravel:php7.4
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/laravel:php8.0
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/laravel:php8.1
```

- See PHP version info

```shell
docker run --name=app --rm -p 80:80 pnlinh/laravel:php7.4
docker run --name=app --rm -p 80:80 pnlinh/laravel:php8.0
docker run --name=app --rm -p 80:80 pnlinh/laravel:php8.1
```

![image](https://user-images.githubusercontent.com/26193890/164198187-743e3585-1379-4d06-a2d5-34330b17d060.png)

### References

- https://github.com/TrafeX/docker-php-nginx
