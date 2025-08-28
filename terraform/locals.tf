locals {
  # Default groups and users
  default_groups = [
    "admins", "devops", "data-eng", "secops", "readonly",
    "s3-rw", "ec2-ops", "rds-ro", "cloudwatch-ro", "support"
  ]

  default_users = [
    "ade","bola","chika","dami","eni","femi","grace","habib","ife",
    "jide","kunle","lara","mike","nike","ola","peter","queen","remi",
    "sade","timi","uche","viktor","wale","yemi","zainab",
    "daniel","lucky","ravi","chandrima","bisi"
  ]

  default_group_policies = {
    admins         = ["AdminFull"]
    devops         = ["ReadOnly", "S3ReadWrite", "EC2StartStop", "CloudWatchRead"]
    data-eng       = ["ReadOnly", "AthenaRead", "S3ReadOnly", "CloudWatchRead"]
    secops         = ["SecurityAudit"]
    readonly       = ["ReadOnly"]
    s3-rw          = ["S3ReadWrite"]
    ec2-ops        = ["EC2StartStop", "SSMDescribe"]
    rds-ro         = ["RDSReadOnly"]
    cloudwatch-ro  = ["CloudWatchRead"]
    support        = ["SupportUser"]
  }

  default_user_groups = {}

  # Fix → wrap with coalesce()
  effective_groups        = length(coalesce(var.groups, [])) > 0 ? var.groups : local.default_groups
  effective_users         = length(coalesce(var.users, [])) > 0 ? var.users : local.default_users
  effective_group_policies = length(coalesce(var.group_policies, {})) > 0 ? var.group_policies : local.default_group_policies
  effective_user_groups    = length(coalesce(var.user_groups, {})) > 0 ? var.user_groups : local.default_user_groups
}

locals {
  # ...your other locals...

  # Map of custom IAM policies created in iam-policies.tf
  custom_policy_arns = {
    AthenaRead     = aws_iam_policy.AthenaRead.arn
    EC2StartStop   = aws_iam_policy.EC2StartStop.arn
    S3ReadOnly     = aws_iam_policy.S3ReadOnly.arn
    S3ReadWrite    = aws_iam_policy.S3ReadWrite.arn
    CloudWatchRead = aws_iam_policy.CloudWatchRead.arn
    SupportUser    = aws_iam_policy.SupportUser.arn
    SSMDescribe    = aws_iam_policy.SSMDescribe.arn
    RDSReadOnly    = aws_iam_policy.RDSReadOnly.arn
  }
}
