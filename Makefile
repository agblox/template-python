SHELL := /bin/bash
# https://www.gushiciku.cn/pl/p6TH
.SHELLFLAGS := -eu -o pipefail -c
.ONESHELL:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules


PACKAGE_NAME := template-python
PACKAGE_PATH := src/template_python
VERSION := 1.5.1
PYTHON_VERSION := $(shell cat .python-version)

.DEFAULT_GOAL = help

##@ Bootstrap
.PHONY: repo-init bootstrap init

repo-init:  ## Install pre-commit in repo
	pre-commit install -t pre-commit -t commit-msg

env-init: clean  ## Initialize local environment
	poetry env use ${PYTHON_VERSION}
	test -e .env && cp .env .old.env
	cat .test.env > .env
	@echo ".env file created, if already existed(if any) .env file was copied to the .old.env"
	echo "dotenv" > .envrc
	@echo ".envrc file created"

bootstrap:  ## Install/update required tools(dev tools included)
	poetry install --extras "dev"

init: repo-init env-init bootstrap  ## All init steps at once

##@ Checks
.PHONY: check mypy

check:  ## Run pre-commit against all files
	pre-commit run --all-files

mypy:  ## Run type checker
	poetry run mypy

##@ Tests
.PHONY: test

test:  ## Run tests
	PYTHONPATH=$(shell pwd)/${PACKAGE_PATH} poetry run pytest

##@ Miscellaneous
.PHONY: secrets-baseline-create secrets-baseline-audit secrets-update refresh-lock clean build-assets replace-me

secrets-baseline-create:  ## Create/update .secrets.baseline file
	poetry run detect-secrets scan --baseline .secrets.baseline

secrets-baseline-audit:  ## Check updated .secrets.baseline file
	poetry run detect-secrets audit .secrets.baseline
	git commit .secrets.baseline --no-verify -m "build(security): update secrets.baseline"

secrets-update: secrets-baseline-create secrets-baseline-audit ## Update secrets

refresh-lock:  ## Refresh the lock file without updates
	poetry lock --no-update

clean:  ## Clean python environment
	rm -rf .coverage .mypy_cache .pytest_cache .venv

build-assets:  ## Build GitHub release assets
	poetry build

replace-me:  ## Find not modified parts of template
	git grep -Ei 'replace*|template*'

##@ Helpers
.PHONY: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
