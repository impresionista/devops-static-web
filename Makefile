compose := docker compose
args ?=


# ------------------------------------------------------------------------------
configure:
	cp .template.env .env
	cp compose-override.template.yml compose-override.yml

bootstrap:
	@echo "Ready to work"

build:
	$(compose) build $(args)

start:
	$(compose) up $(args)

stop:
	$(compose) down $(args)

# ------------------------------------------------------------------------------
deploy/bootstrap:
	terraform -chdir=terraform/bootstrap/ init -var-file="./secrets.tfvars"
	terraform -chdir=terraform/bootstrap/ apply -var-file="./secrets.tfvars"
	@echo ""
	@echo "Copy this bucket name into 'terraform/09.provider.tf' to use the shared state."

deploy/init:
	terraform -chdir=terraform/ init -var-file="./secrets.tfvars"

deploy/validate:
	terraform -chdir=terraform/ validate -var-file="./secrets.tfvars"

deploy/apply:
	terraform -chdir=terraform/ apply -var-file="./secrets.tfvars"

deploy/install:
	...

# ------------------------------------------------------------------------------
.PHONY: configure bootstrap build start stop deploy/bootstrap deploy/init deploy/validate deploy/apply deploy/install
