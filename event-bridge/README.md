# AWS Eventbridge

This module creates the Eventbridge bus and rules in AWS

## Usage example

```tf
module "zvault_eventbridge" {
  source      = ""
  create_rule = true

  # Event Bus
  # Uses 'default' event bus if bus_name not specified
  create_bus = false
  bus_name   = "default"

  # Event Rule
  rule_name          = "Rule name"
  rule_description   = "Rule description"
  rule_event_pattern = <<EOF
    {
        "source": ["aws.autoscaling"],
        "detail-type": ["EC2 Instance-terminate Lifecycle Action"],
        "detail": {
            "AutoScalingGroupName": ["sandbox-zvault"]
        }
    }
    EOF

  # Event Target
  target_id  = module.zvault_lambda.function_name
  target_arn = module.zvault_lambda.arn
}

```
