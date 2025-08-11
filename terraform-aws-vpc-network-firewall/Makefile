.PHONY: fmt assess help

.default: help

help:
	@echo "This Makefile provides commands to manage Terraform VPC resources."
	@echo
	@echo "Usage:"
	@echo "  make <command>"
	@echo
	@echo "Available Commands:"
	@echo "  fmt         format terraform files and update documentation"
	@echo "  assess      run security assessment with tfsec"
	@echo "  help        show this help message"

fmt:
	@terraform fmt --recursive \
	&& terraform-docs markdown table . --output-file parameters.md \
	&& echo "Terraform files formatted and documentation updated successfully."

assess: fmt
	@tfsec