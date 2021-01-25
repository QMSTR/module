.PHONY: build run linters

build:
	docker-compose build module

run:
	docker-compose run module

linters:
	docker run \
		-e RUN_LOCAL=true \
		-e GO111MODULE=on \
		-v $(shell pwd -P):/tmp/lint \
		github/super-linter
