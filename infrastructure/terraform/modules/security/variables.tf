variable "project_name" {
  description = "Name of the platform or project."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be dev, test, or prod."
  }
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created."
  type        = string
}

variable "streaming_port" {
  description = "Port used by the streaming platform."
  type        = number
  default     = 9092

  validation {
    condition     = var.streaming_port >= 1 && var.streaming_port <= 65535
    error_message = "streaming_port must be between 1 and 65535."
  }
}

variable "tags" {
  description = "Additional tags applied to security resources."
  type        = map(string)
  default     = {}
}