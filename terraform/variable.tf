variable "region" {
  type = string
  description = "AWS region"
  default = "us-east-1"
  
}

variable "users" {
  type = list(string)
  description = "List of IAM user names to create"
  
}

variable "groups" {
  type = list(string)
  description = "List of IAM group names to create"
  
}

variable "group_policies" {
  description = "Map of group name -> list of policy identifiers to attach"
  type = map(list(string))
  
}

variable "user_groups" {
  description = "Map of user name -> list of groups they belong to"
  type = map(list(string))

  
}

# Toggle creating console password or access keys 
variable "create_login_profiles" {
  type = bool
  default = false
  
}

variable "create_access_keys" {
  type = bool
  default = false
}