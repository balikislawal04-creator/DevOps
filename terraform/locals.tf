locals {

  # ========= Defaults (safe to edit to your needs) =========
  # If vars are not provided, these will be used.
  default_groups = [
    "admins",
    "devops",
    "data-eng",
    "secops",
    "readonly",
    "s3-rw",
    "ec2-ops",
    "rds-ro",
    "cloudwatch-ro",
    "support",
  ]

  # No default users/user_groups required for validation to pass
  default_users       = [
    "Biola",
    "Bisi",
    "Bola",
    "Mayo",
  ]
  default_user_groups = {}

  # Which policies each group should receive (policy *identifiers*)
  # Identifiers can be:
  # - AWS managed: AdministratorAccess, ReadOnlyAccess, SecurityAudit, AmazonS3ReadOnlyAccess, AmazonS3FullAccess,
  #                AmazonRDSReadOnlyAccess, CloudWatchReadOnlyAccess, AmazonAthenaFullAccess
  # - Custom (from iam-policies.tf): AthenaRead, EC2StartStop, S3ReadOnly, S3ReadWrite, CloudWatchRead, SupportUser, SSMDescribe, RDSReadOnly
  default_group_policies = {
    admins        = ["AdministratorAccess"]
    devops        = ["ReadOnlyAccess", "S3ReadWrite", "EC2StartStop", "CloudWatchRead"]
    data-eng      = ["ReadOnlyAccess", "AthenaRead", "S3ReadOnly", "CloudWatchRead"]
    secops        = ["SecurityAudit"]
    readonly      = ["S3ReadOnly"]
    s3-rw         = ["S3ReadWrite"]
    ec2-ops       = ["EC2StartStop", "SSMDescribe"]
    rds-ro        = ["RDSReadOnly"]
    cloudwatch-ro = ["CloudWatchRead"]
    support       = ["SupportUser"]
  }

  # ========= Null-safe "effective" inputs =========
  # Use provided variables if set, otherwise fall back to defaults above.
  effective_groups         = length(coalesce(var.groups, [])) > 0 ? var.groups         : local.default_groups
  effective_users          = length(coalesce(var.users, [])) > 0 ? var.users           : local.default_users
  effective_group_policies = length(coalesce(var.group_policies, {})) > 0 ? var.group_policies : local.default_group_policies
  effective_user_groups    = length(coalesce(var.user_groups, {})) > 0 ? var.user_groups      : local.default_user_groups

  # Flatten map(group => [policy_ids]) into a list of { group, id }
  policy_pairs = flatten([
    for g, plist in local.effective_group_policies : [
      for p in plist : {
        group = g
        id    = p
      }
    ]
  ])

  # ========= AWS managed policy ARNs (by short identifier used above) =========
  managed_policy_arns = {
    AdministratorAccess     = "arn:aws:iam::aws:policy/AdministratorAccess"
    ReadOnlyAccess          = "arn:aws:iam::aws:policy/ReadOnlyAccess"
    SecurityAudit           = "arn:aws:iam::aws:policy/SecurityAudit"
    AmazonS3ReadOnlyAccess  = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
    AmazonS3FullAccess      = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
    AmazonRDSReadOnlyAccess = "arn:aws:iam::aws:policy/AmazonRDSReadOnlyAccess"
    CloudWatchReadOnlyAccess= "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
    AmazonAthenaFullAccess  = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
  }

  # ========= Custom policy ARNs (from iam-policies.tf) =========
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

  # Subsets of policy_pairs, split into AWS-managed vs custom (for attachments)
  managed_pairs = [for p in local.policy_pairs : p if contains(keys(local.managed_policy_arns), p.id)]
  custom_pairs  = [for p in local.policy_pairs : p if contains(keys(local.custom_policy_arns),  p.id)]
}
