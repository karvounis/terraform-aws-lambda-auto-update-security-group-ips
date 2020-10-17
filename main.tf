locals {
  zip_file_path = "${path.module}/lambda/archive.zip"
}

resource "aws_lambda_function" "this" {
  count = var.enabled ? 1 : 0

  filename         = local.zip_file_path
  function_name    = var.lambda_function_name
  description      = "Updates the security group rules of an security group based on the public IPs of an AutoScaling Group's EC2 instances"
  handler          = "main"
  runtime          = "go1.x"
  source_code_hash = filebase64sha256(local.zip_file_path)
  role             = aws_iam_role.this[0].arn
  memory_size      = var.memory_size
  timeout          = var.timeout

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

resource "aws_iam_role" "this" {
  count = var.enabled ? 1 : 0

  name = "${var.prefix}auto-update-ips"

  assume_role_policy = data.aws_iam_policy_document.assume.json

  tags = var.tags
}

resource "aws_iam_policy" "aws_lamba_auto_update_ips" {
  count = var.enabled ? 1 : 0

  name        = "${var.prefix}lamba-auto-update-ips"
  description = "Lambda policy to auto update IPs in the Security Groups"

  policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_policy_attachment" "aws_lambda_execute" {
  count = var.enabled ? 1 : 0

  name       = "AWSLambdaExecute"
  roles      = [aws_iam_role.this[0].name]
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

resource "aws_iam_policy_attachment" "aws_lamba_auto_update_ips" {
  count = var.enabled ? 1 : 0

  name       = "${var.prefix}lamba-auto-update-ips"
  roles      = [aws_iam_role.this[0].name]
  policy_arn = aws_iam_policy.aws_lamba_auto_update_ips[0].arn
}

resource "aws_cloudwatch_log_group" "example" {
  count = var.enabled ? 1 : 0

  name              = "/aws/lambda/${var.prefix}lambda-name"
  retention_in_days = var.log_group_retention_in_days

  tags = var.tags
}
