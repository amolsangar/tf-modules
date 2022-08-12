# Lambda Function
variable "create_lambda" {
  description = "Controls whether Lambda Function resource should be created"
  type        = bool
  default     = true
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "zvault_lambda_fn"
}

variable "role_arn" {
  description = "Role arn attached to the function"
  type        = string
  default     = ""
}

variable "handler" {
  description = "Handler name for the function"
  type        = string
  default     = "main"
}

variable "publish" {
  description = "Controls lambda function versioning"
  type        = bool
  default     = false
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "go1.x"
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "depends_on_list" {
  description = "Items Lambda function depends upon"
  type        = any
  default     = []
}

# VPC
variable "subnet_ids" {
  description = "List of Subnet IDs"
  type        = any
  default     = []
}

variable "security_group_ids" {
  description = "List of Security Group IDs"
  type        = any
  default     = []
}

# Data archiving 
variable "archive_type" {
  description = "Archive type"
  type        = string
  default     = "zip"
}

variable "archive_output_path" {
  description = "Path of the directory where archived file will be stored"
  type        = string
  default     = "/tmp/lambda_zip_dir.zip"
}

variable "source_dir_path" {
  description = "Path of the directory where code resides"
  type        = string
  default     = "../../lambda_function"
}

# Lambda Permissions (for allowed triggers)
variable "create_permissons" {
  description = "Whether to allow triggers on current version of Lambda Function (this will revoke permissions from previous version because Terraform manages only current resources)"
  type        = bool
  default     = true
}

variable "allowed_triggers" {
  description = "Map of allowed triggers to create Lambda permissions"
  type        = map(any)
  default     = {}
}