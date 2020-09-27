# terraform-aws-lambda-auto-update-security-group-ips

This repo contains the terraform code to create the necessary resources in order to be able to update a Security Group's rules based on the IPs of an Autoscaling Group in AWS.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| asg\_name | Name of the ASG | `string` | n/a | yes |
| enabled | Enables/Disables this module | `bool` | n/a | yes |
| security\_group\_id | ID of the security group to auto update | `string` | n/a | yes |
| vpc\_id | ID of the VPC where to create security group | `string` | n/a | yes |
| log\_group\_retention\_in\_days | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. | `number` | `7` | no |
| prefix | Prefix all resources with this string | `string` | `"tf-"` | no |
| tags | n/a | `map(string)` | `{}` | no |

## Outputs

No output.

