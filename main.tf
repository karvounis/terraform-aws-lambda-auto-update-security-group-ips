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
}
