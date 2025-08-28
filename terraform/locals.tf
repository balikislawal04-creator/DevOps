locals {
  # --------------------------
  # Defaults (edit as you like)
  # --------------------------
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

  default_users = [
    "ade","bola","chika","dami","eni","femi","grace","habib","ife",
    "jide","kunle","lara","mike","nike","ola","peter","queen","remi",
    "sade","timi","uche","viktor","wale","yemi","zainab",
    "daniel","lucky","ravi","chandrima","bisi",
  ]

  # Which policies each group should get (policy names must match what you define in iam-policies.tf)
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

  # Optional: map of group => list(users). Keep empty unless you want to pre-wire memberships.
  default_user_groups = {}

  # Declare but leave empty unless you need to reference extra policy ARNs here.
  # (Do NOT duplicate managed_policy_arns here if you already define them in iam-policies.tf)
  custom_policy_arns = {}

  # --------------------------
  # Effective values (null-safe)
  # --------------------------
  effective_groups = (
    var.groups == null || length(var.groups) == 0
  ) ? local.default_groups : var.groups

  effective_users = (
    var.users == null || length(var.users) == 0
  ) ? local.default_users : var.users

  effective_group_policies = (
    var.group_policies == null || length(var.group_policies) == 0
  ) ? local.default_group_policies : var.group_policies

  # map(string => list(string)) like { "admins" = ["ade","bola"], "readonly" = ["…"] }
  effective_user_groups = (
    var.user_groups == null || length(var.user_groups) == 0
  ) ? local.default_user_groups : var.user_groups
}

