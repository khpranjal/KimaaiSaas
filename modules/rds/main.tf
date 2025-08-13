terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.name}-db"
  engine                  = "postgres"
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  multi_az                = var.multi_az
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = true

  username = var.db_username
  password = var.db_password

  tags = {
    Name = "${var.name}-postgres"
  }
}

output "endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "RDS instance endpoint"
}

output "arn" {
  value       = aws_db_instance.this.arn
  description = "RDS instance ARN"
}

output "id" {
  value       = aws_db_instance.this.id
  description = "RDS instance ID"
}
