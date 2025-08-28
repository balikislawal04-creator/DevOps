# Attach AWS-managed policies
resource "aws_iam_group_policy_attachment" "managed" {
  # Build a map like: "group:id" => { g = group, id = policy_id }
  for_each = {
    for pair in flatten([
      for g, ids in local.effective_group_policies : [
        for id in ids : { g = g, id = id }
      ]
    ]) :
    "${pair.g}:${pair.id}" => pair
    if contains(keys(local.managed_policy_arns), pair.id)
  }

  group      = aws_iam_group.this[each.value.g].name
  policy_arn = local.managed_policy_arns[each.value.id]
}

# Attach custom policies (those defined in aws_iam_policy.*)
resource "aws_iam_group_policy_attachment" "custom" {
  # Same flattening, but filter to custom IDs
  for_each = {
    for pair in flatten([
      for g, ids in local.effective_group_policies : [
        for id in ids : { g = g, id = id }
      ]
    ]) :
    "${pair.g}:${pair.id}" => pair
    if contains(["S3ReadOnly", "S3ReadWrite", "EC2StartStop", "AthenaRead"], pair.id)
  }

  group = aws_iam_group.this[each.value.g].name

  policy_arn = ({
    S3ReadOnly   = aws_iam_policy.S3ReadOnly.arn
    S3ReadWrite  = aws_iam_policy.S3ReadWrite.arn
    EC2StartStop = aws_iam_policy.EC2StartStop.arn
    AthenaRead   = aws_iam_policy.AthenaRead.arn
  })[each.value.id]
}
