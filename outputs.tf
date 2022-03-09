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
