ARG ALPINE_VERSION=3.15
FROM alpine:${ALPINE_VERSION}
LABEL Maintainer="Ngoc Linh Pham <pnlinh1207@gmail.com>"
LABEL Description="Lightweight container with Nginx 1.20 & PHP 7.4 based on Alpine Linux."

# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  php7  \
  php7-fpm  \
  php7-bcmath  \
  php7-ctype  \
  php7-fileinfo \
  php7-json  \
  php7-mbstring  \
  php7-openssl  \
  php7-pdo_pgsql  \
  php7-pdo_mysql \
  php7-curl  \
  php7-pdo  \
  php7-tokenizer  \
  php7-xml \
  php7-phar \
  php7-dom \
  php7-gd \
  php7-iconv \
  php7-xmlwriter \
  php7-xmlreader \
  php7-zip \
  php7-simplexml \
  php7-session \
  curl \
  nginx \
  supervisor

# Install XDebug

# Create symlink so programs depending on `php` still function
RUN cp /usr/bin/php7 /usr/bin/php

# Install Composer
COPY --from=composer/composer:2-bin /composer /usr/bin/composer

# Configure nginx
COPY config/74/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/74/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY config/74/php.ini /etc/php7/conf.d/custom.ini

# Configure supervisord
COPY config/74/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

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

# Switch to use a www user from here on
USER www

# Add application
COPY --chown=www src/ /var/www/html/public

# Expose the port nginx is reachable on
EXPOSE 80

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up & running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/fpm-ping
