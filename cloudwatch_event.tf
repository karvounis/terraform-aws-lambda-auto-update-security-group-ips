resource "aws_cloudwatch_event_rule" "this" {
  count = var.enabled ? 1 : 0

  name        = "${var.prefix}${var.cloudwatch_event_rule_name}"
  description = "Capture the EC2 launch and terminating scaling events"

  event_pattern = <<PATTERN
{
  "detail-type": [
    "EC2 Instance-launch Lifecycle Action",
    "EC2 Instance-terminate Lifecycle Action"
  ],
  "source": [
    "aws.autoscaling"
  ],
  "detail": {
    "AutoScalingGroupName": [
      "${var.autoscaling_group_name}"
    ]
  }
}
PATTERN

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "this" {
  count = var.enabled ? 1 : 0

  rule = aws_cloudwatch_event_rule.this[0].name
  arn  = aws_lambda_function.this[0].arn
}
