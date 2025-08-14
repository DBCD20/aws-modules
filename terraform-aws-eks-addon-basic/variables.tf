variable "vpc_cni_version" {
  description = "Version of the Amazon VPC CNI plugin add-on"
  type        = string
  default     = "v1.18.1-eksbuild.1"
}

variable "coredns_version" {
  description = "Version of the CoreDNS add-on"
  type        = string
  default     = "v1.10.1-eksbuild.2"
}

variable "kube_proxy_version" {
  description = "Version of the kube-proxy add-on"
  type        = string
  default     = "v1.30.0-eksbuild.1"
}
