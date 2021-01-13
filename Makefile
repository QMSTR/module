.PHONY: linters

linters:
	docker run \
		-e RUN_LOCAL=true \
		-v $(shell pwd -P):/tmp/lint \
		github/super-linter
