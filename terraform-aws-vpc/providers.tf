provider "aws" {
  region = "us-west-1"
  default_tags {
    tags = merge({
      Terraform = "true"
    }, local.default_tags)
  }
}
