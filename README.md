# Docker PHP-FPM & Nginx base on Alpine Linux

Lightweight Docker image for PHP development.

### Why should use this image

- Built on the lightweight and
  secure [Alpine Linux](https://www.alpinelinux.org/) distribution
- Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
- Use [runit](http://smarden.org/runit/) instead
  of [supervisor](http://supervisord.org/)
- Tiny Docker image size

### PHP versions supported

- [x] PHP 7.2
- [x] PHP 7.4
- [x] PHP 8.0
- [x] PHP 8.1 (recommend usage)
- [x] PHP 8.2 (recommend usage)
- [x] PHP 8.3
- [x] PHP 8.4

### Stack images

- Laravel: [docker-laravel](https://github.com/pnlinh/docker-laravel)
- Magento: [docker-magento](https://github.com/pnlinh/docker-magento)
- Symfony: In progress
- CodeIgniter: [docker-codeigniter](https://github.com/pnlinh/docker-codeigniter)

### References

- [TrafeX/docker-php-nginx](https://github.com/TrafeX/docker-php-nginx)
- [Runit vs Supervisor](https://bolshov.online/docker/2020/11/18/runit-vs-supervisor)
- [Add trusted root CA to Alpine](https://stackoverflow.com/questions/67231714/how-to-add-trusted-root-ca-to-docker-alpine/67232164#67232164)
