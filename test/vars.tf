variable "tags" {
  default = {
    name = "test"
  }
}
variable "ecs_cluster_config" {
  default = {
    containerInsights = "enabled"
  }
}

variable "launchtemplate_config" {
  default = {
    image_id                             = "ami-0bb273345f0961e90"
    ebs_optimized                        = true
    instance_initiated_shutdown_behavior = "terminate"
    instance_type                        = "t3.nano"
    key_name                             = "ssh_keys_poc"
    monitoring                           = true
  }
}

variable "asg_config" {
  default = {
    min_size              = 1
    max_size              = 1
    desired_capacity      = 1
    protect_from_scale_in = true

  }
}

variable "vpc_config" {
  default = {
    private_subnets = [
      "subnet-0cd23f769e081e3c2",
      "subnet-00f051292d4eeb08b"
    ]
  }
}

variable "ec2_capacityprovider_config" {
  default = {
    managed_termination_protection = "ENABLED"
    managed_scaling = {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }
  }
}
