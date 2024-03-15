FROM pnlinh/codeigniter:php8.2

# Install xdebug
RUN apk add --no-cache php82-pecl-xdebug

# Add configuration
COPY xdebug.ini /etc/php82/conf.d/xdebug.ini
