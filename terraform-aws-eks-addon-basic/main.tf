# EKS VPC CNI Add-on
resource "aws_eks_addon" "vpc_cni" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "vpc-cni"
  addon_version = var.vpc_cni_version
  resolve_conflicts = "OVERWRITE"

  depends_on = [aws_eks_cluster.this]
}

# EKS CoreDNS Add-on
resource "aws_eks_addon" "coredns" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "coredns"
  addon_version = var.coredns_version
  resolve_conflicts = "OVERWRITE"

  depends_on = [aws_eks_cluster.this]
}

# EKS kube-proxy Add-on
resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.this.name
  addon_name    = "kube-proxy"
  addon_version = var.kube_proxy_version
  resolve_conflicts = "OVERWRITE"

  depends_on = [aws_eks_cluster.this]
}
