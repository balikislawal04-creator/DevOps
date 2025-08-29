# Athena read-only
resource "aws_iam_policy" "AthenaRead" {
  name_prefix = "tf-AthenaRead-"
  description = "Read-only access to query/list Athena and results in S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["athena:Get*", "athena:List*", "glue:Get*", "glue:List*", "s3:GetObject*", "s3:ListBucket*"]
      Resource = "*"
    }]
  })
}

# Start/Stop EC2 instances + describe
resource "aws_iam_policy" "EC2StartStop" {
  name_prefix = "tf-EC2StartStop-"
  description = "Allow start/stop and describe EC2 instances"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ec2:StartInstances", "ec2:StopInstances", "ec2:DescribeInstances", "ec2:DescribeInstanceStatus"]
      Resource = "*"
    }]
  })
}

# S3 read-only (bucket list + get object)
resource "aws_iam_policy" "S3ReadOnly" {
  name_prefix = "tf-S3ReadOnly-"
  description = "Read-only access to S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["s3:ListBucket"],  Resource = "*" },
      { Effect = "Allow", Action = ["s3:GetObject*"],  Resource = "*" }
    ]
  })
}

# S3 read/write (list, get, put, delete object)
resource "aws_iam_policy" "S3ReadWrite" {
  name_prefix = "tf-S3ReadWrite-"
  description = "Read/Write access to S3 objects"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      { Effect = "Allow", Action = ["s3:ListBucket"],               Resource = "*" },
      { Effect = "Allow", Action = ["s3:GetObject*", "s3:PutObject*", "s3:DeleteObject*"], Resource = "*" }
    ]
  })
}

# CloudWatch read-only
resource "aws_iam_policy" "CloudWatchRead" {
  name_prefix = "tf-CloudWatchRead-"
  description = "Read-only access to CloudWatch"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["cloudwatch:Get*", "cloudwatch:List*", "logs:Get*", "logs:Describe*", "logs:List*"]
      Resource = "*"
    }]
  })
}

# Support user (basic support console actions)
resource "aws_iam_policy" "SupportUser" {
  name_prefix = "tf-SupportUser-"
  description = "Basic AWS Support center read-only"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["support:Describe*", "support:List*"]
      Resource = "*"
    }]
  })
}

# SSM describe
resource "aws_iam_policy" "SSMDescribe" {
  name_prefix = "tf-SSMDescribe-"
  description = "Describe-only SSM permissions"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ssm:Describe*", "ssm:Get*", "ssm:List*"]
      Resource = "*"
    }]
  })
}

# RDS read-only
resource "aws_iam_policy" "RDSReadOnly" {
  name_prefix = "tf-RDSReadOnly-"
  description = "Read-only access to RDS metadata"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["rds:Describe*", "rds:List*", "rds:DescribeDBInstances"]
      Resource = "*"
    }]
  })
}
