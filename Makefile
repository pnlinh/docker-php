IMAGE?=pnlinh/laravel:php
DOCKER_RUN:=docker run --rm ${IMAGE}${VERSION}
DEFAULT_ARCHS?=linux/arm64
ARCHS?=linux/amd64,linux/arm64,linux/arm/v8,linux/arm/v7,linux/arm/v6

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "⚡ \033[34m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build docker image
	docker buildx build --load --platform $(DEFAULT_ARCHS) -t $(IMAGE)${VERSION} -f ${VERSION}/Dockerfile ${VERSION}/

release: ### Build and push image to DockerHub
	echo "Releasing: ${IMAGE}${VERSION}"
	docker buildx build --push --platform $(ARCHS) -t $(IMAGE)${VERSION} -f ${VERSION}/Dockerfile ${VERSION}/

release-all: ### Build all PHP version and push image to DockerHub
	echo "Releasing all PHP version"
	VERSION=8.4 make release
	VERSION=8.3 make release
	VERSION=8.2 make release
	VERSION=8.1 make release
	VERSION=8.0 make release
	VERSION=7.4 make release
	VERSION=7.2 make release

release-all-to-ghrc: ### Build all PHP version and push image to GitHub Container Registry
	VERSION=8.4 IMAGE=ghcr.io/pnlinh/laravel make release
	VERSION=8.3 IMAGE=ghcr.io/pnlinh/laravel make release
	VERSION=8.2 IMAGE=ghcr.io/pnlinh/laravel make release
	VERSION=8.1 IMAGE=ghcr.io/pnlinh/laravel make release
	VERSION=8.0 IMAGE=ghcr.io/pnlinh/laravel make release
	VERSION=7.4 IMAGE=ghcr.io/pnlinh/laravel make release
	VERSION=7.2 IMAGE=ghcr.io/pnlinh/laravel make release

test: ### Test image
	$(DOCKER_RUN) php -v
	$(DOCKER_RUN) sh -c "php -v | grep ${VERSION}"
	$(DOCKER_RUN) sh -c "php -v | grep OPcache"
	$(DOCKER_RUN) sh -c "nginx -t"

test-all: ### Test all image
	VERSION=8.4 make build test
	VERSION=8.3 make build test
	VERSION=8.2 make build test
	VERSION=8.1 make build test
	VERSION=8.0 make build test
	VERSION=7.4 make build test
	VERSION=7.2 make build test
