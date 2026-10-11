.PHONY: fmt check init validate test

fmt:
	terraform fmt -recursive

check:
	terraform fmt -check -recursive

init:
	terraform init -backend=false

validate:
	terraform validate

test:
	terraform test