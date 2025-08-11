resource "aws_kms_key" "vpc" {
  description             = "KMS key for VPC encryption"
  deletion_window_in_days = var.kms_deletion_window_in_days

  tags = { Name = "${var.project_name}-vpc-kms-key" }
}