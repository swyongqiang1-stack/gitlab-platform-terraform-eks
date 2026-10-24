.PHONY: fmt check init init-ci validate plan test

fmt:
	terraform fmt -recursive

check:
	terraform fmt -check -recursive

init:
	terraform init

init-ci:
	terraform init -backend=false

validate:
	terraform validate

plan:
	terraform plan

test:
	terraform test