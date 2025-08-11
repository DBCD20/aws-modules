resource "aws_flow_log" "this" {
  iam_role_arn    = aws_iam_role.flowlogs.arn
  log_destination = aws_cloudwatch_log_group.flowlogs.arn
  traffic_type    = "ALL"
  vpc_id          = data.aws_vpc.selected.id
}

resource "aws_cloudwatch_log_group" "vpc_flowlogs" {
  name  = "vpc-flowlog-${local.project_name}-${local.environment}"
  encryption_key_id = local.enable_kms ? aws_kms_key.flowlogs.arn : null

    tags = {
    Name          = format("%s-%s-vpc-flowlogs", local.project_name, local.environment)
    Resource_Role = format("cloudwatch log group for: %s-%s-vpc-flowlogs", local.project_name, local.environment)
  }
}
