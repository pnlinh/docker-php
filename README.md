# Docker PHP-FPM & Nginx base on Alpine Linux

Simple docker image for PHP/Laravel development

### Why should use this image

- Built on the lightweight and
  secure [Alpine Linux](https://www.alpinelinux.org/) distribution
- Multi-platform, supporting AMD4, ARMv6, ARMv7, ARM64
- Use [runit](http://smarden.org/runit/) instead
  of [supervisor](http://supervisord.org/)
- Very small Docker image size

### PHP version support

- [x] PHP 7.2
- [x] PHP 7.4
- [x] PHP 8.0
- [x] PHP 8.1 (recommend usage)
- [x] PHP 8.2 (recommend usage)
- [x] PHP 8.3

### How to use

- Build image

```shell
VERSION=7.2 make build # Build image with php 7.2
VERSION=7.4 make build # Build image with php 7.4
VERSION=8.0 make build # Build image with php 8.0
VERSION=8.1 make build # Build image with php 8.1
VERSION=8.2 make build # Build image with php 8.2
VERSION=8.3 make build # Build image with php 8.3
```

- How to customize image name

```shell
VERSION=7.2 IMAGE=archielite/laravel:php make build # Build image with php 7.2
VERSION=7.4 IMAGE=archielite/laravel:php make build # Build image with php 7.4
VERSION=8.0 IMAGE=archielite/laravel:php make build # Build image with php 8.0
VERSION=8.1 IMAGE=archielite/laravel:php make build # Build image with php 8.1
VERSION=8.2 IMAGE=archielite/laravel:php make build # Build image with php 8.2
VERSION=8.3 IMAGE=archielite/laravel:php make build # Build image with php 8.3
```

- Test image by PHP version

```shell
VERSION=8.3 make test
VERSION=8.2 make test
VERSION=8.1 make test
VERSION=8.0 make test
VERSION=7.4 make test
VERSION=7.2 make test
```

- Test all image

```shell
make test-all
```

- Mount your code to be served with container

```shell
docker run --name=app -v /path/to/project:/var/www/html -p 80:80 pnlinh/laravel:php8.1
```

- Using docker-compose

```
version: '3.4'

services:
    app:
        image: pnlinh/laravel:php8.1
        hostname: laravel-app
        container_name: laravel-app
        ports:
            - "80:80"
        volumes:
            - .:/var/www/html
        networks:
            - localnet
networks:
    localnet:
        driver: "bridge"
```

- Browser to: [http://localhost](http://localhost)

![image](https://user-images.githubusercontent.com/26193890/198828634-fc11aaa1-7175-4433-b4f3-755381669e74.png)

### Security scanner

- PHP 8.3

```
trivy image pnlinh/laravel:php8.3
2023-12-10T10:49:03.211+0700	INFO	Vulnerability scanning is enabled
2023-12-10T10:49:03.211+0700	INFO	Secret scanning is enabled
2023-12-10T10:49:03.211+0700	INFO	If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2023-12-10T10:49:03.211+0700	INFO	Please see also https://aquasecurity.github.io/trivy/v0.48/docs/scanner/secret/#recommendation for faster secret detection
2023-12-10T10:49:03.221+0700	INFO	Detected OS: alpine
2023-12-10T10:49:03.221+0700	INFO	Detecting Alpine vulnerabilities...
2023-12-10T10:49:03.223+0700	INFO	Number of language-specific files: 0

pnlinh/laravel:php8.3 (alpine 3.19.0)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

```

- PHP 8.2

```
trivy image pnlinh/laravel:php8.2
2023-10-10T15:02:53.141+0700	INFO	Need to update DB
2023-10-10T15:02:53.142+0700	INFO	DB Repository: ghcr.io/aquasecurity/trivy-db
2023-10-10T15:02:53.142+0700	INFO	Downloading DB...
40.28 MiB / 40.28 MiB [--------------------------------------------------------------------------------------------------] 100.00% 1.62 MiB p/s 25s
2023-10-10T15:03:22.397+0700	INFO	Vulnerability scanning is enabled
2023-10-10T15:03:22.397+0700	INFO	Secret scanning is enabled
2023-10-10T15:03:22.397+0700	INFO	If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2023-10-10T15:03:22.397+0700	INFO	Please see also https://aquasecurity.github.io/trivy/v0.45/docs/scanner/secret/#recommendation for faster secret detection
2023-10-10T15:03:24.592+0700	INFO	Detected OS: alpine
2023-10-10T15:03:24.592+0700	INFO	Detecting Alpine vulnerabilities...
2023-10-10T15:03:24.596+0700	INFO	Number of language-specific files: 0

pnlinh/laravel:php8.2 (alpine 3.18.4)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

- PHP 8.1

```text
trivy image pnlinh/laravel:php8.1
2023-10-10T15:05:27.635+0700	INFO	Vulnerability scanning is enabled
2023-10-10T15:05:27.635+0700	INFO	Secret scanning is enabled
2023-10-10T15:05:27.635+0700	INFO	If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2023-10-10T15:05:27.635+0700	INFO	Please see also https://aquasecurity.github.io/trivy/v0.45/docs/scanner/secret/#recommendation for faster secret detection
2023-10-10T15:06:09.378+0700	INFO	Detected OS: alpine
2023-10-10T15:06:09.378+0700	INFO	Detecting Alpine vulnerabilities...
2023-10-10T15:06:09.391+0700	INFO	Number of language-specific files: 0

pnlinh/laravel:php8.1 (alpine 3.18.4)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

- PHP 7.4
```text
trivy image pnlinh/laravel:php7.4
2023-10-10T15:10:18.620+0700	INFO	Vulnerability scanning is enabled
2023-10-10T15:10:18.620+0700	INFO	Secret scanning is enabled
2023-10-10T15:10:18.620+0700	INFO	If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2023-10-10T15:10:18.620+0700	INFO	Please see also https://aquasecurity.github.io/trivy/v0.45/docs/scanner/secret/#recommendation for faster secret detection
2023-10-10T15:10:40.824+0700	INFO	Detected OS: alpine
2023-10-10T15:10:40.824+0700	INFO	Detecting Alpine vulnerabilities...
2023-10-10T15:10:40.842+0700	INFO	Number of language-specific files: 0

pnlinh/laravel:php7.4 (alpine 3.15.10)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)
```

- PHP 7.2
```text
trivy image pnlinh/laravel:php7.2
2023-10-10T15:11:17.417+0700	INFO	Vulnerability scanning is enabled
2023-10-10T15:11:17.417+0700	INFO	Secret scanning is enabled
2023-10-10T15:11:17.417+0700	INFO	If your scanning is slow, please try '--scanners vuln' to disable secret scanning
2023-10-10T15:11:17.417+0700	INFO	Please see also https://aquasecurity.github.io/trivy/v0.45/docs/scanner/secret/#recommendation for faster secret detection
2023-10-10T15:11:33.151+0700	INFO	Detected OS: alpine
2023-10-10T15:11:33.151+0700	INFO	Detecting Alpine vulnerabilities...
2023-10-10T15:11:33.161+0700	INFO	Number of language-specific files: 0
2023-10-10T15:11:33.161+0700	WARN	This OS version is no longer supported by the distribution: alpine 3.8.5
2023-10-10T15:11:33.161+0700	WARN	The vulnerability detection may be insufficient because security updates are not provided

pnlinh/laravel:php7.2 (alpine 3.8.5)

Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

```

### Add Xdebug

- See [docs/xdebug-support.md](docs/xdebug-support.md)

### Useful images

- Magento: https://github.com/pnlinh/docker-php/tree/feature/magento
- Symfony: https://github.com/pnlinh/docker-php/tree/feature/symfony

### References

- https://github.com/TrafeX/docker-php-nginx
- https://bolshov.online/docker/2020/11/18/runit-vs-supervisor
- https://stackoverflow.com/questions/67231714/how-to-add-trusted-root-ca-to-docker-alpine/67232164#67232164
