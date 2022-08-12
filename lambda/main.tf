# Reference- https://github.com/terraform-aws-modules/terraform-aws-lambda

# ############################################
# Create Lambda function
# ############################################

resource "aws_lambda_function" "main" {
  count = var.create_lambda ? 1 : 0

  # If the file is not in the current working directory, 
  # you will need to include a path.module in the filename
  filename      = data.archive_file.lambda_zip_dir[0].output_path
  function_name = var.function_name
  role          = var.role_arn
  handler       = var.handler
  publish       = var.publish

  source_code_hash = data.archive_file.lambda_zip_dir[0].output_base64sha256
  runtime          = var.runtime

  # VPC
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  # Set environment variables
  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  # ... other configuration ...
  depends_on = [var.depends_on_list]
}

# ############################################
# Archives code in zip format
# ############################################

data "archive_file" "lambda_zip_dir" {
  count       = var.create_lambda ? 1 : 0
  type        = var.archive_type
  output_path = var.archive_output_path
  source_dir  = var.source_dir_path
}

# ############################################
# Create Lambda Permissions
# ############################################

# Allows certain resources to invoke Lambda Function
resource "aws_lambda_permission" "this" {
  for_each = { for k, v in var.allowed_triggers : k => v if var.create_lambda && var.create_permissons }

  function_name = aws_lambda_function.main[0].function_name
  # qualifier     = aws_lambda_function.main[0].version

  statement_id       = try(each.value.statement_id, each.key)
  action             = try(each.value.action, "lambda:InvokeFunction")
  principal          = try(each.value.principal, format("%s.amazonaws.com", try(each.value.service, "")))
  source_arn         = try(each.value.source_arn, null)
  source_account     = try(each.value.source_account, null)
  event_source_token = try(each.value.event_source_token, null)
}

# ############################################
