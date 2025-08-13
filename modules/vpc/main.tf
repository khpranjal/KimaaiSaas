terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.name
  cidr = var.cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = [for i in range(0, 3) : cidrsubnet(var.cidr, 4, i)]
  public_subnets  = [for i in range(3, 6) : cidrsubnet(var.cidr, 4, i)]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

data "aws_availability_zones" "available" {}

output "id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnets
  description = "List of private subnet IDs"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnets
  description = "List of public subnet IDs"
}

