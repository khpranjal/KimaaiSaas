terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.20.0"

  cluster_name                   = var.name
  cluster_version                = var.cluster_version
  cluster_endpoint_public_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  enable_irsa = var.enable_irsa

  eks_managed_node_groups = {
    default = {
      min_size       = var.min_size
      max_size       = var.max_size
      desired_size   = var.desired_capacity
      instance_types = [var.node_instance_type]
      capacity_type  = "ON_DEMAND" # Change to SPOT for cost optimization
    }
  }
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}
