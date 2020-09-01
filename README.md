# Django Girls tutorial

## Introduction

This project more or less follows the [Django Girls Tutorial](https://tutorial.djangogirls.org/en/).

## General Notes

### Running Locally

#### Docker
This project is wired up to work with `Docker`. You aren't required to use it for Django development, but it can make
things easier.

#### Workflow
1. First time: [set up local settings](#local-settings).
2. Spin up the server: [run Django server](#running-the-server).
3. Visit the page you are trying to get to.
    1. Base URL: [http://localhost:8000/](http://localhost:8000/)

### Updating Project Files

1. When updating this project make sure all tests are still passing.
    1. Add/update/remove tests as required for any changes.

### Project Files
This section covers some of the broad-level notes for some of the files/directories included in this repo:
* `djangogirls/settings` - Directory containing settings for project.
    * `__init__.py` - Imports settings as needed from `base.py` and `local.py`.
    * `base.py` - Contains most of the settings needed for the project.
    * `local.py` - Contains settings that shouldn't be committed, whether they are secrets (e.g. `SECRET_KEY`) or things
        that help you run locally how you see fit.
    * `test.py` - Contains test-specific settings, e.g. settings to point to a test DB. Tests will point directly at
        this file.
* `.coveragerc` - Contains settings for the test coverage plugin.
* `.dockerignore` - Contains patterns for files/directories to skip when copying files into the docker build context.
    * Note that this isn't used when mapping volumes into a container.
    * Note that the patterns in this file are mostly also covered in `.gitignore` so if you add patterns to this
        file, consider whether or not they should also go in the other one too.
* `.editorconfig` - Contains some settings for how files to try to keep things consistent across people's different
    editor settings and IDEs.
* `.gitattributes` - Settings for how `git` should treat different files.
* `.gitignore` - Patterns for files/directories to avoid committing to the repository.
    * Note that the patterns in this file are mostly also covered in `.dockerignore` so if you add patterns to this
        file, consider whether or not they should also go in the other one too.
* `conftest.py` - Contains some hooks and fixtures for `pytest` to ease testing, e.g. the `selenium` fixture to run
    functional tests.
* `docker-compose.yaml` - Defines "services" to run our project, e.g. `django` to run local development and testing.
* `Dockerfile` - Defines the execution environment for our project, both locally and deployed. This defines the PyPE
    tools we use as well as which requirements files are installed.
* `Makefile` - Defines "targets" which are shortcuts of sorts, so instead of running something like:
    `docker-compose build --pull django` then `docker-compose up django`, you can just run `make build-local`
    * To see what shortcuts are available along with some help text, you can run `make` on the command line.
    * Note that these are set up to work in Docker only.
* `pyproject.toml` - Defines settings for python tools, for now only for `black`, our linter.
* `pytest.ini` - Defines settings for `pytest`.
* `requirements.txt` - Defines what packages and versions your project needs to run when deployed.
    * Note, you should always include a version. If a version isn't set, it can lead to issues down the road if a
    package gets updated and our deployment installs a version that isn't compatible with our project.
* `test_requirements.txt` - Defines packages and versions your project needs to run locally, meaning things like linting
    and testing packages.
    * Note that versions should still always be included so that the environment each person runs their project/tests in
    locally always matches up to everyone else's.

## Django Local Development

### Local settings
1. Create a file in `djangogirls/settings` called `local.py`.
2. Add `SECRET_KEY = <value>`.

### Running the server
1. Run `make local` inside your local repo.
2. If you want it to re-build the image (if you change the `Dockerfile`, `requirements`, etc.), you can run
    `make build-local`

### Linting Code
This codebase is set up to lint the code using python [black](https://github.com/psf/black). To lint do the following:
1. `make lint`

### Running a django command
1. Run `make django COMMAND="<command to run>"`
    1. E.g. `make django COMMAND="startapp api"`
2. Alternatively, you can run it like this:
    1. Run `docker-compose run --rm django python3 manage.py <command>`
        1. E.g. `docker-compose run --rm django python3 manage.py migrate`

### Running code inside the container
If you want to be able to run things inside the container more than just running a single command, or to move around
and see how things look, you can run this command:
1. `docker-compose run --rm --service-ports django app` or use the Makefile shortcut `make run-container`
    1. `--rm` makes it so that the container gets deleted when you exit it (using `exit`). This can be useful to
        avoid cluttering up your host machine. If you care to keep the container, then take that part off.
    2. `--service-ports` makes it possible to run the server while you're inside the container and be able to access it
        on your host machine. So you can run `python3 manage.py runsslerver` and then visit the page as usual.
    3. `app` is just the name of the service defined in `docker-compose.yaml`
    4. `bash` starts the command line session as a bash session.

### Running tests
1. Run `make test`
    1. If you want to re-build the image (if you change `Dockerfile`), then you can run `make build-test`
    2. If you want to pass some options to `pytest`, you can run the command like this:
        `make test OPTIONS="-s"`

### See Other Helpful make Commands
1. `make help`
