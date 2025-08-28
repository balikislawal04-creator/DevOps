resource "aws_iam_group" "this" {
for_each = toset(local.effective_groups)
name = each.value
}