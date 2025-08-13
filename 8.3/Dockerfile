ARG ALPINE_VERSION=3.20.7
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="Ngoc Linh Pham <pnlinh1207@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.24 & PHP 8.3 based on Alpine Linux."

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  php83  \
  php83-fpm  \
  php83-bcmath  \
  php83-ctype  \
  php83-fileinfo \
  php83-json  \
  php83-mbstring  \
  php83-openssl  \
  php83-pdo_pgsql  \
  php83-pdo_mysql \
  php83-pdo_sqlite \
  php83-curl  \
  php83-pdo  \
  php83-tokenizer  \
  php83-xml \
  php83-phar \
  php83-dom \
  php83-gd \
  php83-iconv \
  php83-xmlwriter \
  php83-xmlreader \
  php83-zip \
  php83-simplexml \
  php83-session \
  php83-opcache \
  php83-intl \
  php83-pcntl \
  php83-posix \
  php83-ftp \
  php83-sodium \
  curl \
  nginx \
  runit

# Create symlink so programs depending on `php` still function
RUN cp /usr/bin/php83 /usr/bin/php

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
