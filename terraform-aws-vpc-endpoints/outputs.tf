output "vpc_endpoint_ids" {
  description = "List of VPC endpoint IDs"
  value       = aws_vpc_endpoint.session_manager[*].id
}

output "vpc_endpoint_dns_names" {
  description = "List of VPC endpoint DNS names"
  value       = aws_vpc_endpoint.session_manager[*].dns_entry[0].dns_name
}