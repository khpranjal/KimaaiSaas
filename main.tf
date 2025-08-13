terraform {
  required_version = ">= 1.6.0"
  backend "s3" {
    bucket         = var.tfstate_bucket
    key            = "kimai/terraform.tfstate"
    region         = var.region
    dynamodb_table = var.tfstate_lock_table
    encrypt        = true
  }
}

provider "aws" { region = var.region }

module "vpc" {
  source = "./modules/vpc"
  name   = var.name
  cidr   = var.vpc_cidr
}

resource "aws_security_group" "efs_sg" {
  name        = "${var.name}-efs-sg"
  description = "Security group for EFS"
  vpc_id      = module.vpc.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"] # Change as per your VPC range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "eks" {
  source               = "./modules/eks"
  name                 = var.name
  vpc_id               = module.vpc.id
  private_subnet_ids   = module.vpc.private_subnet_ids
  public_subnet_ids    = module.vpc.public_subnet_ids
  cluster_version      = "1.29"
  desired_capacity     = 3
  min_size             = 2
  max_size             = 10
  node_instance_type   = "m4i.large"
  enable_irsa          = true
}

module "rds" {
  source                = "./modules/rds_postgres"
  name                  = var.name
  vpc_security_group_ids= [module.vpc.db_sg_id]
  subnet_ids            = module.vpc.private_subnet_ids
  engine_version        = "15"
  instance_class        = "db.t3g.medium"
  allocated_storage     = 50
  multi_az              = true
  backup_retention_period = 7
}

module "efs" {
  source      = "./modules/efs"
  name        = var.name
  subnet_ids  = module.vpc.private_subnet_ids
  security_group_ids = [aws_security_group.efs_sg.id]
}
output "vpc_id" {
  value = module.vpc.id
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "efs_id" {
  value = module.efs.efs_id
}