.PHONY: build run linters

build:
	docker-compose build module

run:
	docker-compose run module

linters:
	docker run \
		-e RUN_LOCAL=true \
		-v $(shell pwd -P):/tmp/lint \
		github/super-linter
