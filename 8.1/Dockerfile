ARG ALPINE_VERSION=3.18.5
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="Ngoc Linh Pham <pnlinh1207@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.24 & PHP 8.1 based on Alpine Linux."

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  php81  \
  php81-fpm  \
  php81-bcmath  \
  php81-ctype  \
  php81-fileinfo \
  php81-json  \
  php81-mbstring  \
  php81-openssl  \
  php81-pdo_pgsql  \
  php81-pdo_mysql \
  php81-curl  \
  php81-pdo  \
  php81-tokenizer  \
  php81-xml \
  php81-phar \
  php81-dom \
  php81-gd \
  php81-iconv \
  php81-xmlwriter \
  php81-xmlreader \
  php81-zip \
  php81-simplexml \
  php81-session \
  php81-opcache \
  php81-gd \
  php81-intl \
  php81-pcntl \
  php81-posix \
  php81-ftp \
  php81-sodium \
  curl \
  nginx \
  runit

# Create symlink so programs depending on `php` still function
RUN cp /usr/bin/php81 /usr/bin/php

# Install Composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

ADD rootfs /
COPY boot.sh /sbin/boot.sh

# Make sure files/folders needed by the processes are accessable when they run under the www user
ARG nginxUID=1000
ARG nginxGID=1000

RUN adduser -D -u ${nginxUID} -g ${nginxGID} -s /bin/sh www && \
    mkdir -p /var/www/html && \
    mkdir -p /var/cache/nginx && \
    chown -R www:www /var/www/html && \
    chown -R www:www /run && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/log/nginx

RUN chmod +x /etc/service/nginx/run \
    && chmod +x /etc/service/php/run

# Expose the port nginx is reachable on
EXPOSE 80

# Let boot start nginx & php-fpm
CMD ["sh", "/sbin/boot.sh"]

# Configure a healthcheck to validate that everything is up & running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping || exit 1
