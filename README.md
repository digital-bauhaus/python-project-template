# Python Project Template

![Tests](https://github.com/digital-bauhaus/python-template/workflows/Tests/badge.svg)

Python packaging can be confusing because there are
[a][borini] [lot][yeaw] [of][bernat] [different][smith] opinions and [loose
standards][pep518].

This is a template for a Python project following all the current best
practices. Since there is not just one way to do those things in Python, this
is also kind of opinionated but I tried to explain my reasons and alternatives,
so read the whole README.
It is configured for Python versions 3.6 and above.

## Developing

[Poetry](https://poetry.eustace.io/) is used to build the package. After
installing Poetry, you can install this package with:

    poetry install

Run the tests manually with:

    poetry run tox

## Getting Started

To use this template for your project, do the following:

1. Update the `[tool.poetry]` section of the `pyproject.toml` with your and you
   package’s information.
2. If you want to use another license, change `COPYING` file and `license`
   section in `pyproject.toml`. You may consider changing the filename of
   `COPYING` if you do not want to use GPL according to the licence’s
   [guidelines][so-licences].
3. Rename `src/sample_package` to `src/$YOURPROJECT` and edit
   `src/$YOURPROJECT/__init__.py` accordingly.

## Poetry Quickstart

Poetry handles all the dependencies and virtual environments for you. To run
your code from and in your virtual environment prepend `poetry run` to your
command. By default, Poetry creates the virtual environments in it’s own
directory.

Since a lot of other tools expect your virtual environments in the project
directory itself as `.venv` the configuration in `poetry.toml` tells Poetry to
do exactly that. If you don’t want this or prefer another name for your virtual
environment (please don’t), you have to remove/adjust the following lines
in `poetry.toml`:

    in-project = true
    path = ".venv"

You can add dependencies with `poetry [-D] add $DEPENDENCY_NAME`, where `-D`
specifies development dependencies, e.g. libraries you need to build and
develop the code that don’t need to be shipped for end users. I advise you to
take a look at the [Poetry documentation][poetry documentation]

## Code Formatting

The source code is formatted with [Black][black].
To format your contributions manually, run

    black src

All code is also automatically checked in the CI and in the pre-commit hook.

## Continuous Integration

CI should work out of the box with the provided configurations in
`.github/workflow`.

It will check the code style with [Black][black] and run the tests with Python
3.6, 3.7, and 3.8.

[borini]: https://stefanoborini.com/current-status-of-python-packaging/
[yeaw]: https://dan.yeaw.me/posts/python-packaging-with-poetry-and-briefcase/
[bernat]: https://www.bernat.tech/pep-517-and-python-packaging/
[smith]: https://medium.com/@grassfedcode/goodbye-virtual-environments-b9f8115bc2b6
[pep518]: https://www.python.org/dev/peps/pep-0518/
[poetry documentation]: https://python-poetry.org/docs/basic-usage/
[black]: https://github.com/python/black
[so-licences]: https://stackoverflow.com/a/5678716
