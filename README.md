# Terraform AWS Modules

## Overview

This repository is a collection of **modular, reusable, and production-ready Terraform modules** designed to provision and manage various **AWS infrastructure components**. Each module follows Terraform best practices and is intended to be easily integrated into your infrastructure-as-code workflows.

The modules are designed for **composability**, meaning they can be used independently or in combination to build scalable, secure, and maintainable AWS environments.

---

## Available Modules

| Module Name            | Description |
|------------------------|-------------|
| [`vpc`](./vpc)                      | Creates a Virtual Private Cloud with subnets, route tables, gateways, and associated networking resources. |
| [`vpc-endpoints`](./terraform-aws-vpc-endpoints) | Provisions AWS Interface and Gateway VPC Endpoints for private connectivity to AWS services. |
| [`vpc-flow-logs`](./terraform-aws-vpc-flow-logs) | Enables VPC Flow Logs to capture IP traffic information for analysis and auditing. |
| [`vpc-network-firewall`](./terraform-aws-vpc-network-firewall) | Deploys AWS Network Firewall resources for advanced VPC traffic inspection and control. |
| [`ecs`](./terraform-aws-ecs)                      | Sets up an AWS ECS Cluster with task definitions, services, and optional Fargate support. |
| [`eks`](./terraform-aws-eks)                      | Deploys a managed AWS EKS Cluster with associated worker nodes, IAM roles, and networking. |

---

## Getting Started

Each module resides in its own subdirectory and includes:

- A standalone `README.md` with detailed usage instructions
- Examples of common configurations
- Input and output variable definitions
- Version and provider requirements

To use a module:

```hcl
module "vpc" {
  source  = "./vpc"
  vpc_cidr = "10.0.0.0/16"
  # other variables...
}
```

> 🛠️ This README and some module documentation were created with the help of ChatGPT to improve clarity and consistency across modules.