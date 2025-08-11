## Overview

This Terraform module provisions a **Virtual Private Cloud (VPC)** and its associated networking components in a cloud environment such as **AWS**, **Google Cloud**, or **Azure**. It is designed to be reusable, configurable, and aligned with infrastructure-as-code best practices.

The module enables the creation of a secure and segmented network architecture by managing key components such as:

- VPC (Virtual Network)
- Subnets (Public and Private)
- Route Tables
- Internet Gateways
- NAT Gateways
- Network ACLs and Security Groups

## Features

- Easily customizable via input variables (e.g., CIDR ranges, subnet counts, availability zones).
- Supports public and private subnet creation.
- Enables centralized or distributed NAT gateway configuration.
- Designed for multi-environment usage (dev, staging, prod).
- Promotes reusability and consistent infrastructure patterns.

## Usage

```hcl
module "vpc_networking" {
  source  = "github.com/your-org/terraform-vpc-networking-module"

  cidr_block             = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  project_name    = "main"
  enable_nat_gateway   = true
  environment          = "dev"
  region               = "us-east-1"
  availability_zones   = ["us-east-1a", "us-east-1b"]
}
```

# Parameters
 
Checkout the available parameters [here]('./parameters.md')