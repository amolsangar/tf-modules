# Lambda Function
output "arn" {
  description = "The ARN of the Lambda Function"
  value       = try(aws_lambda_function.main[0].arn, "")
}

output "function_name" {
  description = "The name of the Lambda Function"
  value       = try(aws_lambda_function.main[0].function_name, "")
}

output "qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = try(aws_lambda_function.main[0].qualified_arn, "")
}

output "version" {
  description = "Latest published version of Lambda Function"
  value       = try(aws_lambda_function.main[0].version, "")
}

output "last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = try(aws_lambda_function.main[0].last_modified, "")
}

output "source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = try(aws_lambda_function.main[0].source_code_hash, "")
}

output "source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = try(aws_lambda_function.main[0].source_code_size, "")
}

output "vpc_id" {
  description = "The size in bytes of the function .zip file"
  value       = try(aws_lambda_function.main[0].vpc_config[0].vpc_id, "")
}