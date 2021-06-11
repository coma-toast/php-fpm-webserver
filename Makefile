.PHONY: help full docker build lint test clean clean-full copy-config git-change-check

SHELL=/bin/bash -o pipefail

.DEFAULT_GOAL := help

help: ## Display general help about this command
	@echo 'Makefile targets:'
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' Makefile \
	| sed -n 's/^\(.*\): \(.*\)##\(.*\)/    \1 :: \3/p' \
	| column -t -c 1  -s '::'

full: lint test build

docker:
	docker build -t :latest .

build: ## Build the application

lint: ## Lint the application

test: ## Test the application

clean: ## Remove files listed in .gitignore (possibly with some exceptions)
	@git init 2> /dev/null
	git clean -Xdff

clean-full:
	@git init 2> /dev/null
	git clean -Xdff

copy-config: ## Copy missing config files into place

git-change-check:
	@git diff --exit-code --quiet || (echo 'There should not be any changes at this point' && git status && exit 1;)
