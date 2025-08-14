variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for EKS"
  type        = list(string)
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
}

variable "node_group_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 3
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "vpc_id" {
  description = "VPC ID where EKS and nodes will run"
  type        = string
}

variable "cluster_security_group_id" {
  description = "EKS cluster's security group ID for control plane communication"
  type        = string
}

variable "enable_ssh" {
  description = "Whether to enable SSH access to worker nodes"
  type        = bool
  default     = false
}

variable "ssh_allowed_cidrs" {
  description = "CIDR blocks allowed to SSH into worker nodes"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_key_name" {
  description = "Name of the EC2 key pair for SSH access to nodes"
  type        = string
  default     = null
}
