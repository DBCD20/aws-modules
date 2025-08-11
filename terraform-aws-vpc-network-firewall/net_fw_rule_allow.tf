resource "aws_networkfirewall_rule_group" "this" {
  capacity    = 50
  description = "Permits http traffic from source"
  name        = "example"
  type        = "STATEFUL"
  rule_group {
    rules_source {
      dynamic "stateful_rule" {
        for_each = local.ips
        content {
          action = "PASS"
          header {
            destination      = "ANY"
            destination_port = "ANY"
            protocol         = "HTTP"
            direction        = "ANY"
            source_port      = "ANY"
            source           = stateful_rule.value
          }
          rule_option {
            keyword  = "sid"
            settings = ["1"]
          }
        }
      }
    }
  }

  tags = {
    Name = each.key
  }
}

locals {
  ips = ["1.1.1.1/32", "1.0.0.1/32"]
}