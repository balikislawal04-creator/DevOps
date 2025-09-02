🚀 IAM Runbook: Automating Users, Groups, and Access Requests
📌 Purpose

This runbook provides a standardized process for handling IAM access requests in AWS using Terraform + GitHub Actions.
It ensures all changes are:

✅ Automated

✅ Version-controlled

✅ Auditable (via PRs and tickets)

⚙️ Pre-requisites

Before using this runbook, make sure you have:

An AWS IAM Role with GitHub OIDC trust (e.g., TerraformDeployRole).

A Terraform project set up in GitHub (files: iam-users.tf, iam-group.tf, variables.tf, locals.tf).

A GitHub Actions workflow (terraform.yml) configured to run Terraform on PR and merge to main.

📝 Workflow Overview

🔄 PR workflow → Terraform plan runs automatically.

✅ Merge to main → Terraform apply runs automatically.

🛡️ All changes are audited and approved via pull requests.

👤 New User Request
Steps:

Open variables.tf.

Add the new user under variable "users". Example:

variable "users" {
  default = [
    "alice",
    "bob"
  ]
}


Commit your changes and open a Pull Request.

GitHub Actions will run terraform plan → review in PR.

Merge to main → GitHub Actions applies changes automatically.

🎉 User is created in AWS IAM.

👥 Add User to Group
Steps:

Open locals.tf.

Add the user → group mapping under effective_group_policies. Example:

effective_group_policies = {
  "admins" = ["alice"]
  "devops" = ["bob"]
}


Commit changes and raise a Pull Request.

Once approved and merged, the pipeline attaches the policies.

📂 Add a New Group
Steps:

Open locals.tf and define the new group. Example:

effective_groups = [
  "admins",
  "devops",
  "support",
  "cloudwatch-ro"
]


Commit changes and raise a Pull Request.

After merge, the group is created in AWS with defined policies.

✅ Best Practices

Always work in a feature branch → PR → Merge.

Double-check the Terraform Plan before merging.

Never apply directly from local without review.

Keep the runbook updated as new groups/policies are added.