variable "keda_chart_version" {
  description = "Version of the KEDA Helm chart"
  type        = string
  default     = "2.14.2" # latest as of Aug 2025
}

variable "sqs_queue_url" {
  description = "The full URL of the SQS queue"
  type        = string
}

variable "sqs_target_deployment" {
  description = "The Kubernetes Deployment name that will be scaled"
  type        = string
}

variable "sqs_queue_arn" {
  description = "ARN of the SQS queue"
  type        = string
}
