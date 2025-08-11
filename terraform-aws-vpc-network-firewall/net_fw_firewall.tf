resource "aws_networkfirewall_firewall" "this" {
  name                   = local.appname
  firewall_policy_arn    = aws_networkfirewall_firewall_policy.this.arn
  vpc_id                 = data.aws_vpc.selected.id
  enabled_analysis_types = ["TLS_SNI", "HTTP_HOST"]
  subnet_mapping {
    subnet_id = data.aws_subnet.selected.id
  }

  timeouts {
    create = "40m"
    update = "50m"
    delete = "1h"
  }
}