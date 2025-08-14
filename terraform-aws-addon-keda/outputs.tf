output "keda_helm_release_status" {
  description = "Status of the KEDA Helm release"
  value       = helm_release.keda.status
}
