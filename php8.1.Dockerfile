ARG ALPINE_VERSION=3.16
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="Ngoc Linh Pham <pnlinh1207@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.20 & PHP 8.1 based on Alpine Linux."

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
  php81-redis \
  php81-pdo_mysql \
  php81-pdo_pgsql \
  php81-pdo_sqlite \
  php81-soap \
  php81-pecl-apcu \
  php81-common \
  php81-sqlite3 \
  php81-session \
  curl \
  nginx \
  runit

# Install XDebug

# Create symlink so programs depending on `php` still function
RUN cp /usr/bin/php81 /usr/bin/php

# Install Composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# Configure nginx
COPY config/81/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/81/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY config/81/php.ini /etc/php81/conf.d/custom.ini

# Configure runit boot script
COPY config/81/boot.sh /sbin/boot.sh

# Make sure files/folders needed by the processes are accessable when they run under the www user
ARG nginxUID=1000
ARG nginxGID=1000

RUN adduser -D -u ${nginxUID} -g ${nginxGID} -s /bin/sh www && \
    mkdir -p /var/www/html && \
    mkdir -p /var/www/html/tmp && \
    mkdir -p /var/cache/nginx && \
    chown -R www:www /var/www/html && \
    chown -R www:www /run && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/log/nginx

COPY config/81/nginx.run /etc/service/nginx/run
COPY config/81/php.run /etc/service/php/run

RUN chmod +x /etc/service/nginx/run \
    && chmod +x /etc/service/php/run

# Add application
COPY --chown=www src/ /var/www/html

# Expose the port nginx is reachable on
EXPOSE 80

# Let boot start nginx & php-fpm
CMD ["sh", "/sbin/boot.sh"]

# Configure a healthcheck to validate that everything is up & running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping
