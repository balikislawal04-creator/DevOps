locals {
  # Default group-to-policy mappings
  default_group_policies = {
    data_eng     = ["ReadOnly", "AthenaRead", "S3ReadOnly", "CloudWatchRead"]
    secops       = ["SecurityAudit"]
    readonly     = ["ReadOnly"]
    s3-rw        = ["S3ReadWrite"]
    ec2-ops      = ["EC2StartStop", "SSMDescribe"]
    rds-ro       = ["RDSReadOnly"]
    cloudwatch-ro= ["CloudWatchRead"]
    support      = ["SupportUser"]
  }

  # Default user-to-groups mapping
  default_user_groups = {}

  # Null-safe coalesce wrappers
  effective_groups       = length(coalesce(var.groups, [])) > 0 ? var.groups : local.default_group_policies
  effective_users        = length(coalesce(var.users, [])) > 0 ? var.users : local.default_users
  effective_user_groups  = length(coalesce(var.user_groups, [])) > 0 ? var.user_groups : local.default_user_groups

  # AWS-managed IAM policies
  managed_policy_arns = {
    AdministratorAccess       = "arn:aws:iam::aws:policy/AdministratorAccess"
    ReadOnlyAccess            = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    SecurityAudit             = "arn:aws:iam::aws:policy/SecurityAudit"
    AmazonS3ReadOnlyAccess    = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    AmazonS3FullAccess        = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    AmazonRDSReadOnlyAccess   = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
    CloudWatchReadOnlyAccess  = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
    AmazonAthenaFullAccess    = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
  }

  # Custom IAM policies (these must exist in iam-policies.tf)
  custom_policy_arns = {
    AthenaRead   = aws_iam_policy.AthenaRead.arn
    EC2StartStop = aws_iam_policy.EC2StartStop.arn
    S3ReadOnly   = aws_iam_policy.S3ReadOnly.arn
    S3ReadWrite  = aws_iam_policy.S3ReadWrite.arn
    CloudWatchRead = aws_iam_policy.CloudWatchRead.arn
    SupportUser  = aws_iam_policy.SupportUser.arn
    SSMDescribe  = aws_iam_policy.SSMDescribe.arn
    RDSReadOnly  = aws_iam_policy.RDSReadOnly.arn
  }
}

