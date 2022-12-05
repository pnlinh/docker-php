ARG ALPINE_VERSION=3.16
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="Ngoc Linh Pham <pnlinh1207@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.22 & PHP 8.0 based on Alpine Linux."

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  php8  \
  php8-fpm  \
  php8-bcmath  \
  php8-ctype  \
  php8-fileinfo \
  php8-json  \
  php8-mbstring  \
  php8-openssl  \
  php8-pdo_pgsql  \
  php8-pdo_mysql \
  php8-pdo_sqlite \
  php8-curl  \
  php8-pdo  \
  php8-tokenizer  \
  php8-xml \
  php8-phar \
  php8-dom \
  php8-gd \
  php8-iconv \
  php8-xmlwriter \
  php8-xmlreader \
  php8-zip \
  php8-simplexml \
  php8-session \
  php8-opcache \
  php8-gd \
  php8-intl \
  curl \
  nginx \
  runit

# Install XDebug

# Create symlink so programs depending on `php` still function
RUN cp /usr/bin/php8 /usr/bin/php

# Install Composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# Configure nginx
COPY config/80/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/80/fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY config/80/php.ini /etc/php8/conf.d/custom.ini

# Configure runit boot script
COPY config/80/boot.sh /sbin/boot.sh

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

COPY config/80/nginx.run /etc/service/nginx/run
COPY config/80/php.run /etc/service/php/run

RUN chmod +x /etc/service/nginx/run \
    && chmod +x /etc/service/php/run

# Add application
COPY --chown=www src/ /var/www/html/public

# Expose the port nginx is reachable on
EXPOSE 80

# Let boot start nginx & php-fpm
CMD ["sh", "/sbin/boot.sh"]

# Configure a healthcheck to validate that everything is up & running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping
