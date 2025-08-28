resource "aws_iam_user_group_membership" "this" {
  for_each = local.effective_user_groups
  user     = aws_iam_user.this[each.key].name
  groups   = [for g in each.value : aws_iam_group.this[g].name]
}
