FROM pnlinh/laravel:php8.2

COPY localhost.pem /usr/local/share/ca-certificates/my-cert.crt
RUN cat /usr/local/share/ca-certificates/my-cert.crt >> /etc/ssl/certs/ca-certificates.crt
COPY localhost*.pem /etc/nginx/ssl/

EXPOSE 80 443
