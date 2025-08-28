# terraform/iam-policies.tf

resource "aws_iam_policy" "CloudWatchRead" {
  name        = "CloudWatchRead"
  description = "Read-only access to CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Get*",
          "logs:Describe*",
          "logs:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "SupportUser" {
  name        = "SupportUser"
  description = "Basic support permissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "support:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "SSMDescribe" {
  name        = "SSMDescribe"
  description = "Describe-only Systems Manager permissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ssm:Describe*",
          "ssm:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "RDSReadOnly" {
  name        = "RDSReadOnly"
  description = "Read-only access to RDS"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "rds:Describe*",
          "rds:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

