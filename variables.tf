
variable "name" {
  type        = string
  description = "Project name prefix for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)"
}

variable "region" {
  type        = string
  description = "AWS region to deploy into"
}

# VPC
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

# EKS
variable "cluster_version" {
  type        = string
  description = "Kubernetes cluster version"
  default     = "1.29"
}

variable "desired_capacity" {
  type        = number
  description = "Desired number of EKS worker nodes"
}

variable "min_size" {
  type        = number
  description = "Minimum number of EKS worker nodes"
}

variable "max_size" {
  type        = number
  description = "Maximum number of EKS worker nodes"
}

variable "node_instance_type" {
  type        = string
  description = "Instance type for EKS worker nodes"
}

variable "enable_irsa" {
  type        = bool
  description = "Enable IAM Roles for Service Accounts"
}

# RDS
variable "engine_version" {
  type        = string
  description = "PostgreSQL engine version for RDS"
}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage in GB for RDS"
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ deployment for RDS"
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
  sensitive   = true
  description = "Database admin password"
}

# EFS
variable "efs_security_group_cidr" {
  type        = list(string)
  description = "List of CIDR blocks allowed to access EFS"
  default     = ["10.0.0.0/8"]
}
