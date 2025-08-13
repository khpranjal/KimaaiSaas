variable "name" {
  type        = string
  description = "Name of the VPC"
}

variable "cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod)"
}
