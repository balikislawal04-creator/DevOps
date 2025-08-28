# Athena read-only (Glue + Athena APIs as needed)
resource "aws_iam_policy" "AthenaRead" {
  name        = "tf-AthenaRead"
  description = "Read-only access to query/list Athena and results in S3"
  policy = jsonencode({
    Version   = "2012-10-17"
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

# Start/Stop EC2 instances + describe
resource "aws_iam_policy" "EC2StartStop" {
  name        = "tf-EC2StartStop"
  description = "Allow start/stop and describe EC2 instances"
  policy = jsonencode({
    Version   = "2012-10-17"
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

# S3 read only (bucket list + get object)
resource "aws_iam_policy" "S3ReadOnly" {
  name        = "tf-S3ReadOnly"
  description = "Read-only access to S3"
  policy = jsonencode({
    Version   = "2012-10-17"
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

# S3 read/write (list, get, put, delete object)
resource "aws_iam_policy" "S3ReadWrite" {
  name        = "tf-S3ReadWrite"
  description = "Read/Write access to S3 objects"
  policy = jsonencode({
    Version   = "2012-10-17"
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

# CloudWatch read access
resource "aws_iam_policy" "CloudWatchRead" {
  name        = "tf-CloudWatchRead"
  description = "Read-only access to CloudWatch metrics/logs"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "cloudwatch:Get*",
          "cloudwatch:List*",
          "logs:Describe*",
          "logs:Get*",
          "logs:List*"
        ]
        Resource = "*"
      }
    ]
  })
}

# SupportUser (typical read + support center)
resource "aws_iam_policy" "SupportUser" {
  name        = "tf-SupportUser"
  description = "Support user read access and support center view"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "support:*Describe*",
          "support:*Get*",
          "support:*List*",
          "trustedadvisor:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# SSM Describe
resource "aws_iam_policy" "SSMDescribe" {
  name        = "tf-SSMDescribe"
  description = "Describe Systems Manager managed instances and ops data"
  policy = jsonencode({
    Version   = "2012-10-17"
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

# RDS ReadOnly
resource "aws_iam_policy" "RDSReadOnly" {
  name        = "tf-RDSReadOnly"
  description = "Read-only access to RDS APIs"
  policy = jsonencode({
    Version   = "2012-10-17"
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

