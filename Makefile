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
install: .install.sentinel

.install.sentinel: $(SOURCES) poetry.lock
	poetry install
	touch .install.sentinel

poetry.lock:
	poetry install
	touch .install.sentinel

.PHONY: codeformat
codeformat: .black.sentinel

.black.sentinel: $(SOURCES)
	poetry run black $(SOURCE_FOLDERS)
	touch .blackl.sentinel

.PHONY: test
test: .lint.sentinel .test.sentinel

.test.sentinel: .install.sentinel
	# only test installed python version
	poetry run tox -e py$(PYTHON_VERSION)
	touch .test.sentinel

.lint.sentinel: .install.sentinel
	poetry run black --check $(SOURCE_FOLDERS)
	poetry run flake8 $(SOURCE_FOLDERS)
	touch .lint.sentinel

.PHONY: distribution
distribution: .dist.sentinel

.dist.sentinel: .test.sentinel
	poetry build
	touch .dist.sentinel

.PHONY: clean
clean:
	rm -rf src/$(MODULE_NAME).egg-info
	rm -rf dist/
	rm -rf .*.sentinel
