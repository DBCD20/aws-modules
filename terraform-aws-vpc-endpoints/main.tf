## ENABLE SESSION MANAGER ON PRIVATE NETWORK
resource "aws_vpc_endpoint" "session_manager" {
  for_each = { for k in local.vpc_endpoint_svc : k => k }

  vpc_id              = var.vpc_id
  service_name        = local.vpc_endpoint_svc[each.key]
  subnet_ids          = var.subnet_ids
  private_dns_enabled = true
  vpc_endpoint_type   = each.key == "com.amazonaws.ap-southeast-1.s3" ? "Gateway" : each.key == "com.amazonaws.ap-southeast-1.dynamodb" ? "Gateway" : "Interface"
}