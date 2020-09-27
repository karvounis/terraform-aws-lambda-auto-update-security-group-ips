variable "enabled" {
  description = "Enables/Disables this module"
  type        = bool
}

variable "prefix" {
  description = "Prefix all resources with this string"
  type        = string
  default     = "tf-"
}

variable "tags" {
  description = ""
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
}

variable "asg_name" {
  description = "Name of the ASG"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to auto update"
  type        = string
}

variable "log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  type        = number
  default     = 7
}
