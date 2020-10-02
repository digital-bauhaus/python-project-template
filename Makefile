SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Project specific variables
SOURCE_FOLDERS = src tests
MODULE_NAME = sample_package

# get current Python 3 version
PYTHON_VERSION=$(shell python3 -c "import sys;t='{v[0]}{v[1]}'.format(v=list(sys.version_info[0:2]));sys.stdout.write(t)")

SOURCES = $(shell find $(SOURCE_FOLDERS) -type f -name '*.py')

.PHONY: install
install: poetry.lock

poetry.lock: pyproject.toml $(SOURCES)
	poetry install

.PHONY: codeformat
codeformat:
	poetry run black $(SOURCE_FOLDERS)

.PHONY: test
test:
	# only test installed python version
	poetry run pytest --cov-append --cov-report=html --cov=src tests

.PHONY: linter
linter: poetry.lock
	poetry run black --check $(SOURCE_FOLDERS)
	poetry run flake8 $(SOURCE_FOLDERS)
	poetry run pylint $(SOURCE_FOLDERS)
	poetry run pydocstyle --ignore=D203,D212,D415 $(SOURCE_FOLDERS)

.PHONY: distribution
distribution: test
	poetry build

.PHONY: clean
clean:
	rm -rf poetry.lock
	rm -rf src/$(MODULE_NAME).egg-info
	rm -rf dist/
