resource "aws_iam_group" "this" {
  for_each = toset(local.effective_groups)

  name = "tf-${each.value}"   # prefix to avoid collision
  path = "/"
}
