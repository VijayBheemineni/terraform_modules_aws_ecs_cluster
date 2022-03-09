output "ecs_cluster_arn" {
  value = module.ecs_cluster.ecs_cluster_arn
}

output "ecs_cluster_ec2_launchtemplate_arn" {
  value = module.ecs_cluster.ecs_cluster_ec2_launchtemplate_arn
}

output "ecs_cluster_ec2_asg_arn" {
  value = module.ecs_cluster.ecs_cluster_ec2_asg_arn
}

output "ecs_cluster_ec2_capacity_provider_arn" {
  value = module.ecs_cluster.ecs_cluster_ec2_capacity_provider_arn
}
