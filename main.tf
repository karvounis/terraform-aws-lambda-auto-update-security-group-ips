locals {
  zip_file_path = "${path.module}/lambda/lambda-payload.zip"
}

resource "aws_lambda_function" "this" {
  count = var.enabled ? 1 : 0

  filename         = local.zip_file_path
  function_name    = "${var.prefix}${var.lambda_function_name}"
  description      = "Updates the security group rules of an security group based on the public IPs of an AutoScaling Group's EC2 instances"
  handler          = "main"
  runtime          = "go1.x"
  source_code_hash = filebase64sha256(local.zip_file_path)
  role             = aws_iam_role.this[0].arn
  memory_size      = var.memory_size
  timeout          = var.timeout

  reserved_concurrent_executions = var.reserved_concurrent_executions

  environment {
    variables = {
      securityGroupID = var.security_group_id
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.vpc_security_group_ids
      subnet_ids         = var.vpc_subnet_ids
    }
  }

  tags = merge(var.tags, var.lambda_tags)
}

resource "aws_lambda_permission" "this" {
  count = var.enabled ? 1 : 0

  statement_id  = "AllowInvokeFunctionFromCloudWatchEvents"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this[0].arn
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.enabled ? 1 : 0

  name              = "${var.log_group_namespace}${aws_lambda_function.this[0].function_name}"
  retention_in_days = var.log_group_retention_in_days

  tags = var.tags
}
