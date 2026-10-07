output "application_security_group_id" {
  description = "ID of the application security group."
  value       = aws_security_group.application.id
}

output "streaming_security_group_id" {
  description = "ID of the streaming security group."
  value       = aws_security_group.streaming.id
}