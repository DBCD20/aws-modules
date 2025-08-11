.PHONY: fmt assess help

.default: help

help:
	@echo "This Makefile provides commands to manage Terraform VPC endpoints resources."
	@echo
	@echo "Usage:"
	@echo "  make <command>"
	@echo
	@echo "Available Commands:"
	@echo "  init        initialize Terraform configuration"
	@echo "  fmt         format terraform files and update documentation"
	@echo "  assess      run security assessment with tfsec"
	@echo "  check       validate Terraform configuration and run security assessment"

	@echo "  help        show this help message"

fmt:
	@terraform fmt --recursive \
	&& terraform-docs markdown table . --output-file parameters.md \
	&& echo "Terraform files formatted and documentation updated successfully."

assess: fmt
	@tfsec

init:
	@terraform init -input=false
	@echo "Terraform initialized successfully."

check: init assess
	@terraform validate
	@echo "Terraform configuration is valid."

cleanup:
	@rm -fr .terraform*
	@echo "Terraform folders cleaned up successfully."