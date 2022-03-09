output "ecs_ec2_instance_role_arn" {
  value = aws_iam_role.ecs_ec2_container_instance_role.arn
}

output "ecs_ec2_instance_profile_arn" {
  value = aws_iam_instance_profile.ecs_ec2_instance_profile.arn
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}


output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_cluster_ec2_launchtemplate_arn" {
  value = aws_launch_template.lt.arn
}

output "ecs_cluster_ec2_asg_arn" {
  value = aws_autoscaling_group.asg.arn
}

output "ecs_cluster_ec2_capacity_provider_arn" {
  value = aws_ecs_capacity_provider.ecs_ec2_cp.arn
}
