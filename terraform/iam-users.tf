resource "aws_iam_user" "this" {
  for_each      = toset(local.effective_users)
  name          = each.value
  force_destroy = true
  tags = { ManagedBy = "terraform" }
}
