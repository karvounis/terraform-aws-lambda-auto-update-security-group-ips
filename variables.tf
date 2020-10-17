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
  description = "The tags to be added to all the resources"
  type        = map(string)
  default     = {}
}

variable "security_group_id" {
  description = "ID of the security group to auto update"
  type        = string
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds. Defaults to 3"
  type        = number
  default     = 3
}

variable "log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  type        = number
  default     = 7
}

variable "lambda_function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
}

variable "lambda_tags" {
  description = "The tags to be added to the lambda function only"
  type        = map(string)
  default     = {}
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids"
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids"
  type        = list(string)
  default     = null
}
