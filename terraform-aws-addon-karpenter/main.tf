resource "kubernetes_manifest" "karpenter_provisioner" {
  manifest = {
    apiVersion = "karpenter.sh/v1alpha5"
    kind       = "Provisioner"
    metadata = {
      name = "default"
    }
    spec = {
      requirements = [
        {
          key      = "node.kubernetes.io/instance-type"
          operator = "In"
          values   = ["m5.large", "m5.xlarge"]
        }
      ]
      limits = {
        resources = {
          cpu    = "1000"
          memory = "1000Gi"
        }
      }
      providerRef = {
        name = "default"
      }
    }
  }
}
