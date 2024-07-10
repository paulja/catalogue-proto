default: help
.PHONY: default

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
.PHONY: help

.ONESHELL:
check:
	@if ! command -v buf &> /dev/null; then echo "buf not found, brew install bufbuild/buf/buf" && exit 1; fi
.PHONY: check

deps: ## get project dependencies
	@go mod tidy
.PHONY: deps

lint: check ## lint the proto buf files
	@buf lint
.PHONY: lint

fmt: check ## format the proto files
	@buf format -w
.PHONY: fmt

gen: check ## generate the code files from the proto file(s)
	@buf generate
.PHONY: gen
