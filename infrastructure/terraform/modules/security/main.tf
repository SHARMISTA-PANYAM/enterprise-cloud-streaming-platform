locals {
  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Component   = "security"
    },
    var.tags
  )
}

resource "aws_security_group" "application" {
  name        = "${var.project_name}-${var.environment}-application-sg"
  description = "Security group for application workloads."
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-application-sg"
    }
  )
}

resource "aws_security_group" "streaming" {
  name        = "${var.project_name}-${var.environment}-streaming-sg"
  description = "Security group for the streaming platform."
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-streaming-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "streaming_from_application" {
  security_group_id            = aws_security_group.streaming.id
  referenced_security_group_id = aws_security_group.application.id

  from_port   = var.streaming_port
  to_port     = var.streaming_port
  ip_protocol = "tcp"

  description = "Allow application workloads to access the streaming platform."
}

resource "aws_vpc_security_group_egress_rule" "application_to_streaming" {
  security_group_id            = aws_security_group.application.id
  referenced_security_group_id = aws_security_group.streaming.id

  from_port   = var.streaming_port
  to_port     = var.streaming_port
  ip_protocol = "tcp"

  description = "Allow application workloads to connect to the streaming platform."
}