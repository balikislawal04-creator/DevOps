locals {
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
  "support"
]


default_users = [
  "ade", "bola", "chika", "dami", "eni", "femi", "grace", "habib", "ife",
  "jide", "kunle", "lara", "mike", "nike", "ola", "peter", "queen", "remi",
  "sade", "timi", "uche", "viktor", "wale", "yemi", "zainab",
  "daniel", "lucky", "ravi", "chandrima", "bisi"
]


# Which policies each group should get (defined in iam-policies.tf)
default_group_policies = {
  admins         = ["AdminFull"],
  devops         = ["ReadOnly", "S3ReadWrite", "EC2StartStop", "CloudWatchRead"],
  data-eng       = ["ReadOnly", "AthenaRead", "S3ReadOnly", "CloudWatchRead"],
  secops         = ["SecurityAudit"],
  readonly       = ["ReadOnly"],
  s3-rw          = ["S3ReadWrite"],
  ec2-ops        = ["EC2StartStop", "SSMDescribe"],
  rds-ro         = ["RDSReadOnly"],
  cloudwatch-ro  = ["CloudWatchRead"],
  support        = ["SupportUser"]
}


# Example membership: first 10 are devs, next 5 analysts, etc.


  default_user_groups = merge(
    { for u in ["ade","bola","chika","dami","eni","femi","grace","habib","ife","jide"] : u => ["devops"] },
    { for u in ["kunle","lara","mike","nike","ola"] : u => ["data-eng"] },
    { for u in ["peter","queen","remi","sade","timi"] : u => ["ec2-ops"] },
    { for u in ["uche","viktor","wale","yemi","zainab"] : u => ["s3-rw"] },
    { for u in ["daniel","lucky","ravi","chandrima"] : u => ["secops"] },
    { for u in ["bisi"] : u => ["admins"] }
  )
}


# Wire locals to variables unless you override them via tfvars


# (You can also pass your own via *.tfvars files.)
# Note: do not declare variables again; use 'locals_as_vars' pattern.
# Wire locals to variables unless you override them via tfvars


# (You can also pass your own via *.tfvars files.)
# Note: do not declare variables again; use 'locals_as_vars' pattern.
locals {
  effective_groups         = coalesce(var.groups, local.default_groups)
  effective_users          = coalesce(var.users, local.default_users)
  effective_group_policies = length(var.group_policies) > 0 ? var.group_policies : local.default_group_policies
  effective_user_groups    = length(var.user_groups) > 0 ? var.user_groups : local.default_user_groups
}