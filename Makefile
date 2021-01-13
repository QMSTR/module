.PHONY: build run linters

# Including all other Makefiles
include $(shell find . -name "Makefile.common")

# Builds the module Docker image
build:
	docker-compose build module

# Runs an interactive shell into the module Docker image
run:
	docker-compose run module

# Runs linters locally
linters:
	docker run \
		-e RUN_LOCAL=true \
		-v $(shell pwd -P):/tmp/lint \
		github/super-linter

integration-test: build
	docker-compose \
		--file tests/integration/docker-compose.yml \
		up
