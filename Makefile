SHELL = /bin/bash

.PHONY: help repo-init bootstrap check tests secrets-baseline-create secrets-baseline-audit \
  refresh-lock

.DEFAULT_GOAL = help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

repo-init:  ## Install pre-commit in repo
	pre-commit install

bootstrap:  ## Install/update required tools(dev tools included)
	poetry install --extras "dev"

check:  ## Run pre-commit against all files
	pre-commit run --all-files

tests:  ## Run tests
	poetry run pytest

test-mypy:  ## Run type check
	poetry run mypy

secrets-baseline-create:  ## Create .secrets.baseline file
	poetry run detect-secrets scan --exclude-files poetry.lock > .secrets.baseline

secrets-baseline-audit:  ## Check updated .secrets.baseline file
	poetry run detect-secrets audit .secrets.baseline

refresh-lock:  ## Refresh the lock file without updates
	poetry lock --no-update
