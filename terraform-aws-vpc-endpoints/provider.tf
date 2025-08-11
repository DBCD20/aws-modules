provider "aws" {
  region = var.aws_region
  default_tags {
    tags = merge({
      Terraform = "true"
    }, var.default_tags)
  }
}