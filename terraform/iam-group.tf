resource "aws_iam_group" "this" {
  for_each = toset(local.effective_groups)

  name = each.key                # group name comes from locals
  path = "/"                     # IAM groups require a path, default is "/"
}
