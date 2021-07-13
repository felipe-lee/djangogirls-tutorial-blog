########################################################################################################################
## For local use #######################################################################################################
########################################################################################################################

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build-dev
build-dev:  ## Build dev image
	docker-compose build --pull app

.PHONY: build-local
build-local:  ## Build dev image and run local webserver at localhost:8000
	$(MAKE) build-dev
	$(MAKE) local

.PHONY: local
local:  ## Run local webserver at localhost:8000
	docker-compose up app

.PHONY: run-container
run-container:  ## Run inside container
	docker-compose run --rm --service-ports app bash

.PHONY: build-test
build-test:  ## Build dev image and run django tests
	$(MAKE) build-dev
	$(MAKE) test

.PHONY: test
test:  ## Run tests. Optionally pass OPTIONS="<your options>" e.g. make test OPTIONS="pets/tests/test_views.py"
	docker-compose run app pytest $(OPTIONS)

.PHONY: lint
lint:  ## Run black to lint code
	docker-compose run --rm app black .

.PHONY: django
django: ## Run a django command, e.g. make django COMMAND=migrate or make django COMMAND='createsuperuser --username=speede --email=speede@gmail.com'
	docker-compose run --rm app python manage.py $(COMMAND)
