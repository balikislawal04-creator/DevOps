# iam-group-policy-attachments.tf
# (No locals here! They live in locals.tf)

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
