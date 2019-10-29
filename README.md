# Python Project Template

Python packaging can be confusing because there are
[a][borini] [lot][yeaw] [of][bernat] [different][smith] opinions and [loose
standards][pep518].

This is a template for a Python project following all the current best
practices. Python versions >3.6 are supported.

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
4. Update `docs/index.rst` with your project’s name.
5. Install [pre-commit][pre-commit] and run 

        pre-commit install

   This will add a Git [hook][git-hooks] that automatically formats your code
   with [Black][black] and runs your tests before committing.

## Developing

[Poetry](https://poetry.eustace.io/) is used to build the package. After
installing Poetry, you can install this package with:

    poetry install

Run the tests manually with:

    tox

## Code Formatting

The source code is formatted with [Black][black].
To format your contributions manually, run

    black src

All code is also automatically checked in the CI.

## Continuous Integration

CI should work out of the box with the provided `.travis.yaml`.

## Continuous Deployment

To enable continuous deployment, you first have to install the
[Travis Command Line Client][travis-cli]. Then, run

    travis setup releases

Confirm the repository and enter you login credentials.
For file to upload enter `dist/*`.

Open `.travis.yml` and add `skip_cleanup: true` and `file_glob: true` to the
`deploy` section. I also recommend adding `tags: true` to the `on` section. This
will configure Travis to only upload a new release on a
[tagged commit][git-tag]. Otherwise, it will do that for every commit. It should
look similar to this:

```yaml
deploy:
  provider: releases
  api_key: "GITHUB OAUTH TOKEN"
  file_glob: true
  file: dist/*
  skip_cleanup: true
  on:
tags: true
```

[borini]: https://stefanoborini.com/current-status-of-python-packaging/
[yeaw]: https://dan.yeaw.me/posts/python-packaging-with-poetry-and-briefcase/
[bernat]: https://www.bernat.tech/pep-517-and-python-packaging/
[smith]: https://medium.com/@grassfedcode/goodbye-virtual-environments-b9f8115bc2b6
[pep518]: https://www.python.org/dev/peps/pep-0518/
[pre-commit]: https://pre-commit.com/
[git-hooks]: https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks
[black]: https://github.com/python/black
[travis-cli]: https://github.com/travis-ci/travis.rb
[git-tag]: https://git-scm.com/book/en/v2/Git-Basics-Tagging
[so-licences]: https://stackoverflow.com/a/5678716
