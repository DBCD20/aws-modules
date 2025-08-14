# --- Security Group for EKS Node Group ---
resource "aws_security_group" "eks_node_group_sg" {
  name        = "${var.cluster_name}-nodegroup-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.cluster_name}-nodegroup-sg"
  }
}

# Allow node-to-node communication
resource "aws_security_group_rule" "node_to_node" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.eks_node_group_sg.id
  security_group_id        = aws_security_group.eks_node_group_sg.id
}

# Allow worker nodes to communicate with control plane (Kubernetes API)
resource "aws_security_group_rule" "node_to_control_plane" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eks_node_group_sg.id
  security_group_id        = var.cluster_security_group_id
}

# Allow outbound internet access from nodes
resource "aws_security_group_rule" "node_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_node_group_sg.id
}

# Optional: Allow SSH to worker nodes
resource "aws_security_group_rule" "ssh_access" {
  count                    = var.enable_ssh ? 1 : 0
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  cidr_blocks              = var.ssh_allowed_cidrs
  security_group_id        = aws_security_group.eks_node_group_sg.id
}

# Attach SG to Node Group
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_node_group_role.arn

  subnet_ids         = var.subnet_ids
  remote_access {
    ec2_ssh_key               = var.enable_ssh ? var.ssh_key_name : null
    source_security_group_ids = [aws_security_group.eks_node_group_sg.id]
  }

  scaling_config {
    desired_size = var.node_group_desired_size
    max_size     = var.node_group_max_size
    min_size     = var.node_group_min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_policy,
    aws_iam_role_policy_attachment.eks_node_group_cni_policy,
    aws_iam_role_policy_attachment.eks_node_group_ecr_policy
  ]
}
