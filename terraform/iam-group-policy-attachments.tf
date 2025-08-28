# Build a flattened list of {group, id} pairs from effective_group_policies
locals {
  policy_pairs = flatten([
    for g, ids in local.effective_group_policies : [
      for id in ids : { group = g, id = id }
    ]
  ])

  managed_pairs = [
    for p in local.policy_pairs : p
    if contains(keys(local.managed_policy_arns), p.id)
  ]

  custom_pairs = [
    for p in local.policy_pairs : p
    if contains(keys(local.custom_policy_arns), p.id)
  ]
}

# Attach AWS managed policies
resource "aws_iam_group_policy_attachment" "managed" {
  for_each  = { for p in local.managed_pairs : "${p.group}:${p.id}" => p }
  group     = aws_iam_group.this[each.value.group].name
  policy_arn = local.managed_policy_arns[each.value.id]
}

# Attach our custom policies
resource "aws_iam_group_policy_attachment" "custom" {
  for_each  = { for p in local.custom_pairs : "${p.group}:${p.id}" => p }
  group     = aws_iam_group.this[each.value.group].name
  policy_arn = local.custom_policy_arns[each.value.id]
}
