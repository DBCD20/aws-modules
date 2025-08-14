output "vpc_cni_addon_arn" {
  description = "ARN of the VPC CNI add-on"
  value       = aws_eks_addon.vpc_cni.addon_arn
}

output "coredns_addon_arn" {
  description = "ARN of the CoreDNS add-on"
  value       = aws_eks_addon.coredns.addon_arn
}

output "kube_proxy_addon_arn" {
  description = "ARN of the kube-proxy add-on"
  value       = aws_eks_addon.kube_proxy.addon_arn
}
