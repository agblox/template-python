SHELL = /bin/bash
.DEFAULT_GOAL = help

PACKAGE_NAME := template-python
PACKAGE_PATH := src/template_python

VERSION := 1.4.0

##@ Bootstrap
.PHONY: repo-init bootstrap

repo-init:  ## Install pre-commit in repo
	pre-commit install -t pre-commit -t commit-msg

bootstrap:  ## Install/update required tools(dev tools included)
	poetry install --extras "dev"


##@ Checks
.PHONY: check mypy

check:  ## Run pre-commit against all files
	pre-commit run --all-files

mypy:  ## Run type checker
	poetry run mypy

##@ Tests
.PHONY: test

test:  ## Run tests
	PYTHONPATH=$(shell pwd)/${PACKAGE_PATH} poetry run pytest --cov-config=.coveragerc --cov=src 2>&1 | tee pytest-coverage.txt

##@ Miscellaneous
.PHONY: secrets-baseline-create secrets-baseline-audit secrets-update refresh-lock clean

secrets-baseline-create:  ## Create/update .secrets.baseline file
	poetry run detect-secrets scan --baseline .secrets.baseline

secrets-baseline-audit:  ## Check updated .secrets.baseline file
	poetry run detect-secrets audit .secrets.baseline
	git commit .secrets.baseline --no-verify -m "build(security): update secrets.baseline"

secrets-update: secrets-baseline-create secrets-baseline-audit ## Update secrets

refresh-lock:  ## Refresh the lock file without updates
	poetry lock --no-update

clean:  ## Clean python environment
	poetry install --remove-untracked
	rm -rf .coverage .mypy_cache .pytest_cache

build-assets:  ## Build GitHub release assets
	poetry build

##@ Helpers
.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
