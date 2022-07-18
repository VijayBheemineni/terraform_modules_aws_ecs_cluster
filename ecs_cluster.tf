/*
  Below code blocks creates ECS EC2 Instance Role.
*/
data "aws_iam_policy" "ssm_full_access" {
  name = "AmazonSSMFullAccess"
}

data "aws_iam_policy" "ec2_container_service" {
  name = "AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role" "ecs_ec2_container_instance_role" {
  name               = join("_", [var.tags.name, "ecs_ec2_container_instance_role"])
  assume_role_policy = file("${path.module}/policies/ecs_ec2_container_instance_trust_policy.json")
}

resource "aws_iam_role_policy_attachment" "ssm_full_access_attachment" {
  role       = aws_iam_role.ecs_ec2_container_instance_role.id
  policy_arn = data.aws_iam_policy.ssm_full_access.arn
}

resource "aws_iam_role_policy_attachment" "ec2_container_service_attachment" {
  role       = aws_iam_role.ecs_ec2_container_instance_role.id
  policy_arn = data.aws_iam_policy.ec2_container_service.arn
}

resource "aws_iam_instance_profile" "ecs_ec2_instance_profile" {
  name = var.tags.name
  role = aws_iam_role.ecs_ec2_container_instance_role.name
}

/*
  Below code blocks creates ECS Task Execution Role
*/


resource "aws_iam_role" "ecs_task_execution_role" {
  name               = join("_", [var.tags.name, "ecs_task_execution_role"])
  assume_role_policy = file("${path.module}/policies/ecs_task_execution_role_trust_policy.json")
}

resource "aws_iam_policy" "ecs_task_execution_role_policy" {
  name   = join("_", [var.tags.name, "ecs_task_execution_role"])
  policy = file("${path.module}/policies/ecs_task_execution_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.id
  policy_arn = aws_iam_policy.ecs_task_execution_role_policy.arn
}

/*
  Below code block creates bare mininum ECS cluster.
*/
resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.tags.name
  setting {
    name  = "containerInsights"
    value = local.ecs_cluster_config.containerInsights
  }
}

/*
  Below code blocks create required configuration for EC2 launch template.
*/
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.tags.name]
  }
}

resource "aws_security_group" "ecs_ec2_instances" {
  name        = join("_", [var.tags.name, "ecs_ec2_instances"])
  description = join(" ", [var.tags.name, "security group used by ECS ec2 instances"])
  vpc_id      = data.aws_vpc.vpc.id

  /*
    Commented below SSH rule because as its rendundant.Since we are allowing
    all traffic within VPC Network.
  */
  # ingress {
  #   description = "SSH access within VPC network."
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  # }

  ingress {
    description = "Allow all traffic within VPC network. This is required for container port access through SSH tunnel."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = join("_", [var.tags.name, "ecs_ec2_instances"])
    }
  )
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "lt" {
  name                                 = var.tags.name
  description                          = join(" ", [var.tags.name, "aws launch template"])
  image_id                             = local.launchtemplate_config.image_id
  ebs_optimized                        = local.launchtemplate_config.ebs_optimized
  instance_initiated_shutdown_behavior = local.launchtemplate_config.instance_initiated_shutdown_behavior
  instance_type                        = local.launchtemplate_config.instance_type
  key_name                             = local.launchtemplate_config.key_name
  monitoring {
    enabled = local.launchtemplate_config.monitoring
  }
  user_data = base64encode(
    templatefile(
      "${path.module}/templates/user_data.sh",
      {
        cluster_name = var.tags.name
      }
    )
  )
  vpc_security_group_ids = [aws_security_group.ecs_ec2_instances.id]
  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_ec2_instance_profile.arn
  }
}

/*
  Below code block creates ASG used by ECS EC2 Capacity Provider.
*/
resource "aws_autoscaling_group" "asg" {
  name             = var.tags.name
  max_size         = local.asg_config.min_size
  min_size         = local.asg_config.max_size
  desired_capacity = local.asg_config.desired_capacity
  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  protect_from_scale_in = local.asg_config.protect_from_scale_in
  vpc_zone_identifier   = local.vpc_config.private_subnets
}

/*
  Below code block creates ECS EC2 capacity provider.
*/
resource "aws_ecs_capacity_provider" "ecs_ec2_cp" {
  name = var.tags.name
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_termination_protection = local.ec2_capacityprovider_config.managed_termination_protection
    managed_scaling {
      maximum_scaling_step_size = local.ec2_capacityprovider_config.managed_scaling.maximum_scaling_step_size
      minimum_scaling_step_size = local.ec2_capacityprovider_config.managed_scaling.minimum_scaling_step_size
      status                    = local.ec2_capacityprovider_config.managed_scaling.status
      target_capacity           = local.ec2_capacityprovider_config.managed_scaling.target_capacity
    }
  }
}

/*
  Below code block attaches capacity providers to ECS cluster and
  defines default capacity provider strategy. 
*/
resource "aws_ecs_cluster_capacity_providers" "cluster_providers" {
  cluster_name = aws_ecs_cluster.ecs_cluster.name
  capacity_providers = [
    "FARGATE",
    var.tags.name
  ]
  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
  depends_on = [
    aws_ecs_capacity_provider.ecs_ec2_cp
  ]
}
