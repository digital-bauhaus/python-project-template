SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# get current Python version
PYTHON_VERSION=$(shell python -c "import sys;t='{v[0]}{v[1]}'.format(v=list(sys.version_info[0:2]));sys.stdout.write(t)")
SOURCE_FOLDERS = src tests
MODULE_NAME = configuration_network

.PHONY: install
install:
	poetry install

.PHONY: codeformat
codeformat: $(SOURCE_FOLDERS)
	poetry run black $(SOURCE_FOLDERS)

.PHONY: test
test: lint
	# only test installed python version
	poetry run tox -e py$(PYTHON_VERSION)

.PHONY: lint
lint:
	poetry run black --check $(SOURCE_FOLDERS)
	poetry run flake8 $(SOURCE_FOLDERS)

.PHONY: build
build: install
	poetry build

.PHONY: clean
clean:
	rm -rf data
	rm -rf poetry.lock
	rm -rf src/$(MODULE_NAME)/$(MODULE_NAME).egg-info
	rm -rf dist/
	rm -rf htmlcov
