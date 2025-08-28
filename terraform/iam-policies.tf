# Define reusable policy documents
# Keep policies small and specific; attach to groups as needed


data "aws_iam_policy_document" "ReadOnly" {
  statement {
    actions = ["*:*"]
    resources = ["*"]
    effect = "Allow"
    condition {
      test = "StringEquals"
      variable = "aws:RequestTag/ReadOnly"
      values = ["true"]
  }
 }
}


# For simplicity in a lab, we'll use AWS managed policies where possible.
# For custom fine-grained examples, see below.


locals {
  managed_policy_arns = {
    AdminFull = "arn:aws:iam::aws:policy/AdministratorAccess"
    ReadOnly = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    SecurityAudit = "arn:aws:iam::aws:policy/SecurityAudit"
    CloudWatchRead = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
    SupportUser = "arn:aws:iam::aws:policy/AWSSupportAccess"
    RDSReadOnly = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
    SSMDescribe = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
  }
}
# Custom inline policies where managed ones don’t exist or are too broad




data "aws_iam_policy_document" "S3ReadOnly" {
  statement {
    actions = [
      "s3:Get*",
      "s3:List*"
    ]
    resources = ["*"]
  }
}




resource "aws_iam_policy" "S3ReadOnly" {
  name = "S3ReadOnly"
  policy = data.aws_iam_policy_document.S3ReadOnly.json
}




data "aws_iam_policy_document" "S3ReadWrite" {
  statement {
    actions = [
      "s3:Get*", "s3:List*", "s3:Put*", "s3:DeleteObject"
    ]
    resources = ["*"]
  }
}




resource "aws_iam_policy" "S3ReadWrite" {
  name = "S3ReadWrite"
  policy = data.aws_iam_policy_document.S3ReadWrite.json
}



data "aws_iam_policy_document" "EC2StartStop" {
  statement {
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:DescribeInstances"
    ]
    resources = ["*"]
  }
}




resource "aws_iam_policy" "EC2StartStop" {
  name = "EC2StartStop"
  policy = data.aws_iam_policy_document.EC2StartStop.json
}
data "aws_iam_policy_document" "AthenaRead" {
  statement {
    actions = [
      "athena:Get*", "athena:List*",
      "glue:Get*", "glue:List*",
      "s3:Get*", "s3:List*"
    ]
    resources = ["*"]
  }
}


resource "aws_iam_policy" "AthenaRead" {
  name = "AthenaRead"
  policy = data.aws_iam_policy_document.AthenaRead.json
}


