## IAM Role for VPC Flow Logs
data "aws_iam_policy_document" "vpc_flowlogs" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "flowlogs" {
  name               = "flowlogs"
  assume_role_policy = data.aws_iam_policy_document.vpc_flowlogs.json
}

data "aws_iam_policy_document" "flowlogs_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_role_policy" "flowlogs" {
  name   = "vpc-flowlogs"
  role   = aws_iam_role.flowlogs.id
  policy = data.aws_iam_policy_document.flowlogs_policy.json
}