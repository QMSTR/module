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

# Integration test
#
# The module should be able to reach all the other components
integration-test: build

	# Running the test
	#
	# Retrieves `module`'s return code, and terminates
	# the test as soon as it returns
	docker-compose \
		--file tests/integration/docker-compose.yml \
		up \
		--exit-code-from module
	
	# Manually removing containers on fail
	docker-compose \
		--file tests/integration/docker-compose.yml \
		down
