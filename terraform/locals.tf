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
    "ade","bola","chika","dami","eni","femi","grace","habib","ife",
    "jide","kunle","lara","mike","nike","ola","peter","queen","remi",
    "sade","timi","uche","viktor","wale","yemi","zainab",
    "daniel","lucky","ravi","chandrima","bisi"
  ]

  default_group_policies = {
    admins        = ["AdministratorAccess"]
    devops        = ["ReadOnlyAccess","S3ReadWrite","EC2StartStop","CloudWatchRead"]
    data-eng      = ["SecurityAudit"]
    secops        = ["ReadOnlyAccess"]
    readonly      = ["ReadOnlyAccess"]
    s3-rw         = ["S3ReadWrite"]
    ec2-ops       = ["EC2StartStop","SSMDescribe"]
    rds-ro        = ["RDSReadOnlyAccess"]
    cloudwatch-ro = ["CloudWatchReadOnlyAccess"]
    support       = ["SupportUser"]
  }
}

