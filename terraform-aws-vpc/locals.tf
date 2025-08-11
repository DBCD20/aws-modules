locals {
  default_tags = {
    Terraform   = true
    Environment = local.environment
  }

  environment       = replace(var.environment, "-", "_")
  project_name      = replace(var.project_name, "-", "_")
  create_db_subnets = length(var.database_subnets) > 0
  route             = [{ cidr_block = "0.0.0.0/0" }]
  config = {
    dev = {

    }
  }
}