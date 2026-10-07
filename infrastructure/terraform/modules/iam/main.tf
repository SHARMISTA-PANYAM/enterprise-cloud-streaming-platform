locals {
  common_tags = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Component   = "iam"
    },
    var.tags
  )
}

data "aws_iam_policy_document" "workload_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"

      identifiers = [
        var.trusted_service_principal
      ]
    }
  }
}

resource "aws_iam_role" "application" {
  name = "${var.project_name}-${var.environment}-application-role"

  assume_role_policy = data.aws_iam_policy_document.workload_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name     = "${var.project_name}-${var.environment}-application-role"
      Workload = "application"
    }
  )
}

resource "aws_iam_role" "streaming" {
  name = "${var.project_name}-${var.environment}-streaming-role"

  assume_role_policy = data.aws_iam_policy_document.workload_assume_role.json

  tags = merge(
    local.common_tags,
    {
      Name     = "${var.project_name}-${var.environment}-streaming-role"
      Workload = "streaming"
    }
  )
}