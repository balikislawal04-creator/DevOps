##############################
# Athena Read Policy
##############################
resource "aws_iam_policy" "AthenaRead" {
  name        = "AthenaRead"
  description = "Read-only access to query/list Athena and results in S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "athena:Get*",
          "athena:List*",
          "glue:Get*",
          "glue:List*",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = "*"
      }
    ]
  })
}

##############################
# EC2 Start/Stop Policy
##############################
resource "aws_iam_policy" "EC2StartStop" {
  name        = "EC2StartStop"
  description = "Allow start/stop and describe EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus"
        ]
        Resource = "*"
      }
    ]
  })
}

##############################
# S3 ReadOnly Policy
##############################
resource "aws_iam_policy" "S3ReadOnly" {
  name        = "S3ReadOnly"
  description = "Read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "*"
      }
    ]
  })
}

##############################
# S3 ReadWrite Policy
##############################
resource "aws_iam_policy" "S3ReadWrite" {
  name        = "S3ReadWrite"
  description = "Read/Write access to S3 objects"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:ListBucket"]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "*"
      }
    ]
  })
}

##############################
# CloudWatch Read Policy
##############################
resource "aws_iam_policy" "CloudWatchRead" {
  name        = "CloudWatchRead"
  description = "Read-only access to CloudWatch metrics/logs"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Get*",
          "logs:List*",
          "logs:Describe*"
        ]
        Resource = "*"
      }
    ]
  })
}

##############################
# Support User Policy
##############################
resource "aws_iam_policy" "SupportUser" {
  name        = "SupportUser"
  description = "Access AWS Support Center read-only"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "support:Describe*",
          "support:Get*",
          "support:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

##############################
# SSM Describe Policy
##############################
resource "aws_iam_policy" "SSMDescribe" {
  name        = "SSMDescribe"
  description = "Describe SSM managed instances and parameters"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ssm:Describe*",
          "ssm:Get*",
          "ssm:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

##############################
# RDS ReadOnly Policy
##############################
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
          "rds:ListTagsForResource"
        ]
        Resource = "*"
      }
    ]
  })
}

