terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.2.0"
    }
  }
  required_version = "~> 1.1.7"
}

provider "aws" {
  region = "us-east-1"
}

module "ecs_cluster" {
  #   source = "git::https://github.com/VijayBheemineni/terraform_modules_aws_sshkey.git?ref=v0.1.0"
  source                      = "../../terraform_modules_aws_ecs_cluster"
  tags                        = var.tags
  ecs_cluster_config          = var.ecs_cluster_config
  launchtemplate_config       = var.launchtemplate_config
  asg_config                  = var.asg_config
  vpc_config                  = var.vpc_config
  ec2_capacityprovider_config = var.ec2_capacityprovider_config
}
