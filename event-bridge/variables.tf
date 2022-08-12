# Bus
variable "create_bus" {
  description = "Controls whether EventBridge Bus should be created"
  type        = bool
  default     = false
}

variable "bus_name" {
  description = "A unique name for your EventBridge Bus"
  type        = string
  default     = "default"
}

# Rule
variable "create_rule" {
  description = "Controls whether EventBridge rule should be created"
  type        = bool
  default     = true
}

variable "rule_name" {
  description = "A unique name for your Event Rule"
  type        = string
  default     = "zvault-asg-filter"
}

variable "rule_description" {
  description = "Event Rule Description"
  type        = string
  default     = "Capture each ASG EC2 Termination"
}

variable "rule_event_pattern" {
  description = "Event Rule Pattern Body"
  type        = string
  default     = <<EOF
    {
        "source": [""],
        "detail-type": [""]
    }
    EOF
}

# Target
variable "target_id" {
  description = "A unique name for your Target ID"
  type        = string
  default     = "zvault_event_target_id"
}

variable "target_arn" {
  description = "A unique name for your Target ARN"
  type        = string
  default     = "zvault_event_target_arn"
}