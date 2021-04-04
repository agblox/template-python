SHELL = /bin/bash

.PHONY: help repo-init hook-checks

.DEFAULT_GOAL = help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

repo-init:  ## Install pre-commit in repo
	pre-commit install

check:  ## Run pre-commit against all files
	pre-commit run --all-files
