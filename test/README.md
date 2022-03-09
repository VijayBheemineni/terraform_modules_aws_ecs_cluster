<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 4.2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs_cluster"></a> [ecs\_cluster](#module\_ecs\_cluster) | ../../terraform_modules_aws_ecs_cluster | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_config"></a> [asg\_config](#input\_asg\_config) | n/a | `map` | <pre>{<br>  "desired_capacity": 1,<br>  "max_size": 1,<br>  "min_size": 1,<br>  "protect_from_scale_in": true<br>}</pre> | yes |
| <a name="input_ec2_capacityprovider_config"></a> [ec2\_capacityprovider\_config](#input\_ec2\_capacityprovider\_config) | n/a | `map` | <pre>{<br>  "managed_scaling": {<br>    "maximum_scaling_step_size": 1000,<br>    "minimum_scaling_step_size": 1,<br>    "status": "ENABLED",<br>    "target_capacity": 100<br>  },<br>  "managed_termination_protection": "ENABLED"<br>}</pre> | yes |
| <a name="input_ecs_cluster_config"></a> [ecs\_cluster\_config](#input\_ecs\_cluster\_config) | n/a | `map` | <pre>{<br>  "containerInsights": "enabled"<br>}</pre> | yes |
| <a name="input_launchtemplate_config"></a> [launchtemplate\_config](#input\_launchtemplate\_config) | n/a | `map` | <pre>{<br>  "ebs_optimized": true,<br>  "image_id": "ami-0bb273345f0961e90",<br>  "instance_initiated_shutdown_behavior": "terminate",<br>  "instance_type": "t3.nano",<br>  "key_name": "ssh_keys_poc",<br>  "monitoring": true<br>}</pre> | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map` | <pre>{<br>  "name": "test"<br>}</pre> | yes |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | n/a | `map` | <pre>{<br>  "private_subnets": [<br>    "subnet-0cd23f769e081e3c2",<br>    "subnet-00f051292d4eeb08b"<br>  ]<br>}</pre> | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_ecs_cluster_ec2_asg_arn"></a> [ecs\_cluster\_ec2\_asg\_arn](#output\_ecs\_cluster\_ec2\_asg\_arn) | n/a |
| <a name="output_ecs_cluster_ec2_capacity_provider_arn"></a> [ecs\_cluster\_ec2\_capacity\_provider\_arn](#output\_ecs\_cluster\_ec2\_capacity\_provider\_arn) | n/a |
| <a name="output_ecs_cluster_ec2_launchtemplate_arn"></a> [ecs\_cluster\_ec2\_launchtemplate\_arn](#output\_ecs\_cluster\_ec2\_launchtemplate\_arn) | n/a |
<!-- END_TF_DOCS -->