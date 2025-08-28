# Region (set a default so it's optional)
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# Optional overrides; if null/empty, locals.tf values are used via coalesce()/length()>0 checks.
variable "users" {
  description = "Override: list of IAM users to create (optional)"
  type        = list(string)
  default     = null
}

variable "groups" {
  description = "Override: list of IAM groups to create (optional)"
  type        = list(string)
  default     = null
}

variable "group_policies" {
  description = "Override: map of group -> list of policy identifiers (optional)"
  type        = map(list(string))
  default     = {}
}

variable "user_groups" {
  description = "Override: map of group -> list of users for membership (optional)"
  type        = map(list(string))
  default     = {}
}

variable "create_login_profiles" {
  description = "Whether to create console login profiles for users"
  type        = bool
  default     = false
}

variable "create_access_keys" {
  description = "Whether to create access keys for users"
  type        = bool
  default     = false
}
