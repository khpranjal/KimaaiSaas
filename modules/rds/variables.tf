variable "name" {
  type        = string
  description = "prefix for RDS instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of VPC security group IDs"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS subnet group"
}

variable "engine_version" {
  type        = string
  description = "PostgreSQL engine version"
}

variable "instance_class" {
  type        = string
  description = "Instance class for RDS"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage in GB"
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ deployment"
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention period in days"
}

variable "db_username" {
  type        = string
  description = "Database admin username"
}

variable "db_password" {
  type        = string
  description = "Database admin password"
  sensitive   = true
}
