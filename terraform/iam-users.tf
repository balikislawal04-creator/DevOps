resource "aws_iam_user" "this" {
  for_each      = toset(local.effective_users)
  name          = each.value
  force_destroy = true # lab convenience; remove in prod
  # tags = local.default_tags # <-- optional
}

# Optional: create console login profiles (passwords)
resource "aws_iam_user_login_profile" "this" {
  for_each                 = var.create_login_profiles ? aws_iam_user.this : {}
  user                     = each.value.name
  password_length          = 20
  password_reset_required  = true
}

# Optional: create access keys (not recommended in prod)
resource "aws_iam_access_key" "this" {
  for_each = var.create_access_keys ? aws_iam_user.this : {}
  user     = each.value.name
}

output "iam_access_keys" {
  value = var.create_access_keys ? {
    for k, v in aws_iam_access_key.this : k => {
      access_key_id     = v.id
      secret_access_key = v.secret
    }
  } : {}
  sensitive = true
}
