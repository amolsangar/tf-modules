# AWS Lambda

This module creates the Lambda Function in AWS

## Usage example

```tf
module "zvault_lambda" {
  source = ""

  # Lambda
  create_lambda = true
  function_name = "lambda_function_name"
  role_arn      = try(aws_iam_role.zvault_lambda_role[0].arn, "")
  handler       = "main"
  runtime       = "go1.x"
  publish       = false

  # Code archiving
  source_dir_path = "../../lambda_function"

  # VPC
  subnet_ids         = ["subnet-0210f835849f4534c"]
  security_group_ids = ["sg-00519ec94089c9d8f"]

  # Environment variables to pass into Lambda function
  environment_variables = {
    var1 = "value1",
    var2 = "value2",
    var3 = "value3"
  }

  create_permissons = var.create && var.create_lambda_permissions
  # Allow Event Bridge Rule to invoke Lambda
  allowed_triggers = {
    EventBridgeRule = {
      statement_id = "AllowExecutionFromCloudWatch"
      principal    = "events.amazonaws.com"
      source_arn   = module.zvault_eventbridge.rule_arn
    }
  }

  depends_on_list = [
    aws_iam_policy_attachment.zvault_lambda_policy_attach
  ]
}

```
