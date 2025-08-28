locals {
  # --- Defaults (your source of truth) ---
  default_groups = [
    "admins","devops","data-eng","secops","readonly",
    "s3-rw","ec2-ops","rds-ro","cloudwatch-ro","support"
  ]

  default_users = [
    "ade","bola","chika","dami","eni","femi","grace","habib","ife",
    "jide","kunle","lara","mike","nike","ola","peter","queen","remi",
    "sade","timi","uche","viktor","wale","yemi","zainab",
    "daniel","lucky","ravi","chandrima","bisi"
  ]

  # Group -> policy identifiers (mix of managed IDs and custom IDs)
  default_group_policies = {
    admins        = ["AdministratorAccess"]
    devops        = ["ReadOnlyAccess","AmazonS3FullAccess","EC2StartStop","CloudWatchReadOnlyAccess"]
    data-eng      = ["ReadOnlyAccess","AmazonAthenaFullAccess","AmazonS3ReadOnlyAccess","CloudWatchReadOnlyAccess"]
    secops        = ["SecurityAudit"]
    readonly      = ["ReadOnlyAccess"]
    s3-rw         = ["AmazonS3FullAccess"]
    ec2-ops       = ["EC2StartStop","SSMDescribe"]
    rds-ro        = ["AmazonRDSReadOnlyAccess"]
    cloudwatch-ro = ["CloudWatchReadOnlyAccess"]
    support       = ["SupportUser"]
  }

  # User -> groups (everyone readonly + a few overrides)
  default_user_groups = merge(
    { for u in local.default_users : u => ["readonly"] },
    {
      ade   = ["admins"]
      bola  = ["devops"]
      femi  = ["secops"]
      lucky = ["devops"]
      ravi  = ["secops"]
      bisi  = ["support"]
    }
  )

  # --- Effective values (variables can override, but you prefer locals) ---
  effective_groups         = coalesce(var.groups, local.default_groups)
  effective_users          = coalesce(var.users,  local.default_users)
  effective_group_policies = length(var.group_policies) > 0 ? var.group_policies : local.default_group_policies
  effective_user_groups    = length(var.user_groups)    > 0 ? var.user_groups    : local.default_user_groups

  # AWS managed policy ARNs keyed by their friendly identifiers
  managed_policy_arns = {
    AdministratorAccess        = "arn:aws:iam::aws:policy/AdministratorAccess"
    ReadOnlyAccess             = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    SecurityAudit              = "arn:aws:iam::aws:policy/SecurityAudit"
    AmazonS3ReadOnlyAccess     = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    AmazonS3FullAccess         = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    AmazonRDSReadOnlyAccess    = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
    CloudWatchReadOnlyAccess   = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
    AmazonAthenaFullAccess     = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
  }
}

