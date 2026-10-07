variable "project_name" {
  description = "Name of the platform or project."
  type        = string

  validation {
    condition     = length(var.project_name) >= 3
    error_message = "project_name must contain at least 3 characters."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be dev, test, or prod."
  }
}

variable "trusted_service_principal" {
  description = "AWS service allowed to assume the workload IAM roles."
  type        = string

  default = "ec2.amazonaws.com"
}

variable "tags" {
  description = "Additional tags applied to IAM resources."
  type        = map(string)
  default     = {}
}