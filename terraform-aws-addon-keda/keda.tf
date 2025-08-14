resource "helm_release" "keda" {
  name       = "keda"
  namespace  = "keda"
  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  version    = var.keda_chart_version

  create_namespace = true

  values = [
    yamlencode({
      image = {
        pullPolicy = "IfNotPresent"
      }
      podSecurityContext = {
        runAsNonRoot = true
      }
    })
  ]

  depends_on = [
    aws_eks_cluster.this,
    kubernetes_namespace.keda
  ]
}

# Namespace resource (optional, for more control)
resource "kubernetes_namespace" "keda" {
  metadata {
    name = "keda"
  }
}

resource "aws_iam_role_policy" "eks_nodegroup_sqs" {
  name = "${var.cluster_name}-nodegroup-sqs-policy"
  role = aws_iam_role.eks_node_group_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:ChangeMessageVisibility"
        ]
        Effect   = "Allow"
        Resource = var.sqs_queue_arn
      }
    ]
  })
}
