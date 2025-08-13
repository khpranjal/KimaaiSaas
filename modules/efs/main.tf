terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

resource "aws_efs_file_system" "this" {
  creation_token = var.name
  encrypted      = true

  tags = {
    Name = "${var.name}-efs"
  }
}

resource "aws_efs_mount_target" "this" {
  for_each = toset(var.subnet_ids)

  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = each.value
  security_groups = var.security_group_ids
}

output "efs_id" {
  value       = aws_efs_file_system.this.id
  description = "The ID of the EFS file system"
}

output "efs_arn" {
  value       = aws_efs_file_system.this.arn
  description = "The ARN of the EFS file system"
}
