<!-- BEGIN_TF_DOCS -->
## Description
    This module creates
        a) ECS Cluster
        b) ECS EC2 Capacity Provider
        c) Sets ECS Default Capacity Provider Strategy as Fargate
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.asg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_ecs_capacity_provider.ecs_ec2_cp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_capacity_provider) | resource |
| [aws_ecs_cluster.ecs_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_cluster_capacity_providers.cluster_providers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |
| [aws_launch_template.lt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_config"></a> [asg\_config](#input\_asg\_config) | n/a | <pre>object({<br>    min_size              = number<br>    max_size              = number<br>    desired_capacity      = number<br>    protect_from_scale_in = bool<br>  })</pre> | n/a | yes |
| <a name="input_ec2_capacityprovider_config"></a> [ec2\_capacityprovider\_config](#input\_ec2\_capacityprovider\_config) | n/a | <pre>object({<br>    managed_termination_protection = string<br>    managed_scaling = object({<br>      maximum_scaling_step_size = number<br>      minimum_scaling_step_size = number<br>      status                    = string<br>      target_capacity           = number<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_ecs_cluster_config"></a> [ecs\_cluster\_config](#input\_ecs\_cluster\_config) | n/a | <pre>object({<br>    containerInsights = string<br>  })</pre> | n/a | yes |
| <a name="input_launchtemplate_config"></a> [launchtemplate\_config](#input\_launchtemplate\_config) | n/a | <pre>object({<br>    image_id                             = string<br>    ebs_optimized                        = bool<br>    instance_initiated_shutdown_behavior = string<br>    instance_type                        = string<br>    key_name                             = string<br>    monitoring                           = bool<br>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | n/a | <pre>object({<br>    private_subnets = list(string)<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_ecs_cluster_ec2_asg_arn"></a> [ecs\_cluster\_ec2\_asg\_arn](#output\_ecs\_cluster\_ec2\_asg\_arn) | n/a |
| <a name="output_ecs_cluster_ec2_capacity_provider_arn"></a> [ecs\_cluster\_ec2\_capacity\_provider\_arn](#output\_ecs\_cluster\_ec2\_capacity\_provider\_arn) | n/a |
| <a name="output_ecs_cluster_ec2_launchtemplate_arn"></a> [ecs\_cluster\_ec2\_launchtemplate\_arn](#output\_ecs\_cluster\_ec2\_launchtemplate\_arn) | n/a |
<!-- END_TF_DOCS -->