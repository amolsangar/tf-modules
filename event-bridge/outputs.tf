# EventBridge
output "bus_name" {
  description = "The EventBridge Bus Name"
  value       = var.bus_name
}

output "bus_arn" {
  description = "The EventBridge Bus Arn"
  value       = try(aws_cloudwatch_event_bus.zvault_event_bus[0].arn, "")
}

output "rule_arn" {
  description = "The EventBridge Rule Arn"
  value       = try(aws_cloudwatch_event_rule.zvault_event_rule[0].arn, "")
}