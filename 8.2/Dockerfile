ARG ALPINE_VERSION=3.18
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="Ngoc Linh Pham <pnlinh1207@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.24 & PHP 8.2 based on Alpine Linux."

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  php82  \
  php82-fpm  \
  php82-bcmath  \
  php82-ctype  \
  php82-fileinfo \
  php82-json  \
  php82-mbstring  \
  php82-openssl  \
  php82-pdo_pgsql  \
  php82-pdo_mysql \
  php82-curl  \
  php82-pdo  \
  php82-tokenizer  \
  php82-xml \
  php82-phar \
  php82-dom \
  php82-gd \
  php82-iconv \
  php82-xmlwriter \
  php82-xmlreader \
  php82-zip \
  php82-simplexml \
  php82-session \
  php82-opcache \
  php82-gd \
  php82-intl \
  php82-pcntl \
  php82-posix \
  php82-ftp \
  curl \
  nginx \
  runit

# Create symlink so programs depending on `php` still function
RUN cp /usr/bin/php82 /usr/bin/php

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
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping
