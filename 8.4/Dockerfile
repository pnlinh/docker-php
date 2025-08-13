ARG ALPINE_VERSION=3.21
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="Ngoc Linh Pham <pnlinh1207@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.24 & PHP 8.4 based on Alpine Linux."

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  php84  \
  php84-fpm  \
  php84-bcmath  \
  php84-ctype  \
  php84-fileinfo \
  php84-json  \
  php84-mbstring  \
  php84-openssl  \
  php84-pdo_pgsql  \
  php84-pdo_mysql \
  php84-pdo_sqlite \
  php84-curl  \
  php84-pdo  \
  php84-tokenizer  \
  php84-xml \
  php84-phar \
  php84-dom \
  php84-gd \
  php84-iconv \
  php84-xmlwriter \
  php84-xmlreader \
  php84-zip \
  php84-simplexml \
  php84-session \
  php84-opcache \
  php84-intl \
  php84-pcntl \
  php84-posix \
  php84-ftp \
  php84-sodium \
  curl \
  nginx \
  runit

# Create symlink so programs depending on `php` still function
RUN cp /usr/bin/php84 /usr/bin/php

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
