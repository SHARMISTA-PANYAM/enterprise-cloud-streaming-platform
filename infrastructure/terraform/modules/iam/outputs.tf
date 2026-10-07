output "application_role_arn" {
  description = "ARN of the application workload IAM role."
  value       = aws_iam_role.application.arn
}

output "application_role_name" {
  description = "Name of the application workload IAM role."
  value       = aws_iam_role.application.name
}

output "streaming_role_arn" {
  description = "ARN of the streaming workload IAM role."
  value       = aws_iam_role.streaming.arn
}

output "streaming_role_name" {
  description = "Name of the streaming workload IAM role."
  value       = aws_iam_role.streaming.name
}