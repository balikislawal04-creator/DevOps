output "group_names" {
  value = [for g in aws_iam_group.this : g.name]
}


output "user_names" {
  value = [for u in aws_iam_user.this : u.name]
}