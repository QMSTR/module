.PHONY: build linters

build:
	docker-compose build module

linters:
	docker run \
		-e RUN_LOCAL=true \
		-v $(shell pwd -P):/tmp/lint \
		github/super-linter
