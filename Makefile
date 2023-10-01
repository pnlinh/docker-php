IMAGE:=pnlinh/laravel:php
DOCKER_RUN:=docker run --rm ${IMAGE}${VERSION}
ARCHS?=linux/arm/v8

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "⚡ \033[34m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build docker image
	docker buildx build --load --platform $(ARCHS) -t $(IMAGE)${VERSION} -f ${VERSION}/Dockerfile ${VERSION}/

test: ### Test image
	$(DOCKER_RUN) php -v
	$(DOCKER_RUN) sh -c "php -v | grep ${VERSION}"
	$(DOCKER_RUN) sh -c "php -v | grep OPcache"

test-all: ### Test all image
	VERSION=8.2 make build
	VERSION=8.2 make test
