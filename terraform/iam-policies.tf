# Athena read-only (via Glue + Athena APIs as needed)
resource "aws_iam_policy" "AthenaRead" {
  name        = "AthenaRead"
  description = "Read-only access to query/list Athena and results in S3"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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
  name        = "EC2StartStop"
  description = "Allow start/stop and describe EC2 instances"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
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

# S3 read/write (list, get, put, delete object)
resource "aws_iam_policy" "S3ReadWrite" {
  name        = "S3ReadWrite"
  description = "Read/Write access to S3 objects"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:ListBucket"
        ]
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

