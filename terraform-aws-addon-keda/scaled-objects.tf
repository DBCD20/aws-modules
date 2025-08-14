# Example: SQS-triggered autoscaling for a Kubernetes Deployment
resource "kubernetes_manifest" "keda_scaledobject" {
  manifest = {
    apiVersion = "keda.sh/v1alpha1"
    kind       = "ScaledObject"
    metadata = {
      name      = "sqs-consumer-scaledobject"
      namespace = "default"
    }
    spec = {
      scaleTargetRef = {
        # Must match the Deployment name
        name = var.sqs_target_deployment
      }
      pollingInterval = 30     # Check metrics every 30 seconds
      cooldownPeriod  = 300    # Wait 5 mins before scaling down
      minReplicaCount = 1
      maxReplicaCount = 10
      triggers = [
        {
          type = "aws-sqs-queue"
          metadata = {
            queueURL      = var.sqs_queue_url
            awsRegion     = var.region
            queueLength   = "5" # Scale up if >5 messages in queue
          }
          authenticationRef = {
            name = "keda-aws-auth"
          }
        }
      ]
    }
  }
}

# Authentication for AWS in KEDA
resource "kubernetes_manifest" "keda_aws_trigger_auth" {
  manifest = {
    apiVersion = "keda.sh/v1alpha1"
    kind       = "TriggerAuthentication"
    metadata = {
      name      = "keda-aws-auth"
      namespace = "default"
    }
    spec = {
      podIdentity = {
        provider = "aws-eks"
      }
    }
  }
}
