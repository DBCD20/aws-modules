locals {
  vpc_endpoint_svc = [
    "com.amazonaws.ap-southeast-1.ssm",
    "com.amazonaws.ap-southeast-1.ec2messages",
    "com.amazonaws.ap-southeast-1.ssmmessages",
    "com.amazonaws.ap-southeast-1.s3",
    "com.amazonaws.ap-southeast-1.logs",
    "com.amazonaws.ap-southeast-1.cloudwatch",
    "com.amazonaws.ap-southeast-1.secretsmanager",
    "com.amazonaws.ap-southeast-1.kms",
  ]
}