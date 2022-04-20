# Docker PHP
Simple docker image for PHP development

# How to use
- Build image first
```shell
docker build -f Dockerfile.74 . -t pnlinh/php:74
docker build -f Dockerfile.80 . -t pnlinh/php:80
```
- Run new container
```shell
docker run --rm --name=app -p 80:80 pnlinh/php:74
```
- Open browser, access [localhost](http://localhost)

![image](https://user-images.githubusercontent.com/26193890/164198187-743e3585-1379-4d06-a2d5-34330b17d060.png)
