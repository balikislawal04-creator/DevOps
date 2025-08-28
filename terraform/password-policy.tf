# Optional: set account password policy for console logins
resource "aws_iam_account_password_policy" "this" {
minimum_password_length = 14
require_lowercase_characters = true
require_numbers = true
require_uppercase_characters = true
require_symbols = true
allow_users_to_change_password = true
hard_expiry = false
max_password_age = 90
password_reuse_prevention = 24
}