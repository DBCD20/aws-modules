variable "subnet_ids" {
  description = "List of subnet IDs to create the VPC endpoints in"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where the endpoints will be created"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "ap-southeast-1"
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {}
}