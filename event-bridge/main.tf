# Reference - https://github.com/terraform-aws-modules/terraform-aws-eventbridge

# ############################################
# Create Event Bus
# ############################################

resource "aws_cloudwatch_event_bus" "zvault_event_bus" {
  count = var.create_bus ? 1 : 0
  name  = var.create_bus ? var.bus_name : ""
}

# ############################################
# Create Event Rule
# ############################################

# Uses 'default' event bus when empty
resource "aws_cloudwatch_event_rule" "zvault_event_rule" {
  count          = var.create_rule ? 1 : 0
  name           = var.rule_name
  description    = var.rule_description
  event_bus_name = var.create_bus ? aws_cloudwatch_event_bus.zvault_event_bus[0].name : var.bus_name
  event_pattern  = var.rule_event_pattern
}

# ############################################
# Create Event Target
# ############################################

resource "aws_cloudwatch_event_target" "target" {
  count          = var.create_rule ? 1 : 0
  rule           = aws_cloudwatch_event_rule.zvault_event_rule[0].name
  event_bus_name = var.create_bus ? aws_cloudwatch_event_bus.zvault_event_bus[0].name : var.bus_name
  target_id      = var.target_id
  arn            = var.target_arn
}

# ############################################
