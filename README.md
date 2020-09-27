# terraform-aws-lambda-auto-update-security-group-ips

This repo contains the terraform code to create the necessary resources in order to be able to update a Security Group's rules based on the IPs of an Autoscaling Group in AWS.

## Required Inputs

The following input variables are required:

### asg\_name

Description: Name of the ASG

Type: `string`

### enabled

Description: Enables/Disables this module

Type: `bool`

### security\_group\_id

Description: ID of the security group to auto update

Type: `string`

### vpc\_id

Description: ID of the VPC where to create security group

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### log\_group\_retention\_in\_days

Description: Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire.

Type: `number`

Default: `7`

### prefix

Description: Prefix all resources with this string

Type: `string`

Default: `"tf-"`

### tags

Description: n/a

Type: `map(string)`

Default: `{}`

## Outputs

No output.

