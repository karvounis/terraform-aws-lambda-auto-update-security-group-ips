data "aws_autoscaling_group" "this" {
  name = var.autoscaling_group_name
}

resource "aws_autoscaling_lifecycle_hook" "launch" {
  count = var.enabled ? 1 : 0

  name                   = "${var.prefix}asg-launch"
  autoscaling_group_name = data.aws_autoscaling_group.this.name
  default_result         = "ABANDON"
  heartbeat_timeout      = var.lifecycle_hook_heartbeat_timeout
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_LAUNCHING"
}

resource "aws_autoscaling_lifecycle_hook" "terminate" {
  count = var.enabled ? 1 : 0

  name                   = "${var.prefix}asg-terminate"
  autoscaling_group_name = data.aws_autoscaling_group.this.name
  default_result         = "ABANDON"
  heartbeat_timeout      = var.lifecycle_hook_heartbeat_timeout
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"
}
