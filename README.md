# Docker PHP-FPM & Nginx base on Alpine Linux
Simple docker image for PHP development

# How to use
- First, build image
```shell
docker build -f Dockerfile.74 . -t pnlinh/php:74
docker build -f Dockerfile.80 . -t pnlinh/php:80
```

- Mount your code to be served with container
```shell
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/php:74
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/php:80
```

- See PHP version info
```shell
docker run --rm -p 80:80 pnlinh/php:74
docker run --rm -p 80:80 pnlinh/php:80
```
  ![image](https://user-images.githubusercontent.com/26193890/164198187-743e3585-1379-4d06-a2d5-34330b17d060.png)

