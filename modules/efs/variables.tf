variable "name" {
  type        = string
  description = "Name prefix for the EFS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where EFS mount targets will be created"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security groups to associate with EFS mount targets"
}
