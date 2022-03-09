variable "tags" {}

variable "ecs_cluster_config" {
  type = object({
    containerInsights = string
  })
}

variable "launchtemplate_config" {
  type = object({
    image_id                             = string
    ebs_optimized                        = bool
    instance_initiated_shutdown_behavior = string
    instance_type                        = string
    key_name                             = string
    monitoring                           = bool
  })
}

variable "asg_config" {
  type = object({
    min_size              = number
    max_size              = number
    desired_capacity      = number
    protect_from_scale_in = bool
  })
}

variable "vpc_config" {
  type = object({
    private_subnets = list(string)
  })
}

variable "ec2_capacityprovider_config" {
  type = object({
    managed_termination_protection = string
    managed_scaling = object({
      maximum_scaling_step_size = number
      minimum_scaling_step_size = number
      status                    = string
      target_capacity           = number
    })
  })
}

locals {
  default_ecs_cluster_config = {
    containerInsights = "enabled"
  }
  ecs_cluster_config = merge(
    local.default_ecs_cluster_config,
    var.ecs_cluster_config
  )

  default_launchtemplate_config = {
    instance_type = "t3.nano"
  }
  launchtemplate_config = merge(
    local.default_launchtemplate_config,
    var.launchtemplate_config
  )

  default_asg_config = {
    min_size              = 1
    max_size              = 1
    desired_capacity      = 1
    protect_from_scale_in = true
  }
  asg_config = merge(
    local.default_asg_config,
    var.asg_config
  )

  default_vpc_config = {
  }
  vpc_config = merge(
    local.default_vpc_config,
    var.vpc_config
  )

  default_ec2_capacityprovider_config = {
    managed_termination_protection = "ENABLED"
    managed_scaling = {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
  ec2_capacityprovider_config = merge(
    local.default_ec2_capacityprovider_config,
    var.ec2_capacityprovider_config
  )
}
