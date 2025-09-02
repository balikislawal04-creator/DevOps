IAM Runbook – Automating User, Group, and Access Requests
📌 Purpose

This runbook provides a standardized process for handling IAM access requests in AWS using Terraform + GitHub Actions.
It ensures changes are:

Automated

Version-controlled

Auditable (via PRs and tickets)

✅ Pre-requisites

AWS IAM Role with GitHub OIDC trust (TerraformDeployRole)

Terraform project set up in GitHub (iam-users.tf, iam-group.tf, variables.tf, locals.tf)

GitHub Actions workflow (terraform.yml) configured:

plan runs on PR

apply runs on merge to main

🔹 Workflow
1. New User Request

Steps:

Open variables.tf.

Add user to the users list:

variable "users" {
  default = [
    "alice",
    "bob",
    "newuser"   # <-- add here
  ]
}


Assign groups in the user_groups map:

variable "user_groups" {
  default = {
    alice   = ["readonly"]
    bob     = ["devops"]
    newuser = ["s3-rw"]
  }
}


Commit to a feature branch:

git checkout -b feature/add-newuser
git add variables.tf
git commit -m "Add newuser to users and s3-rw group (Ticket #1234)"
git push origin feature/add-newuser


Open PR → Review → Merge.

GitHub Actions auto-applies → user created + added to group.

2. New Group Request

Steps:

Edit locals.tf.

Add group name under default_groups:

default_groups = [
  "admins",
  "devops",
  "readonly",
  "s3-rw",
  "newgroup"   # <-- added
]


Add policies for the new group:

default_group_policies = {
  newgroup = ["ReadOnlyAccess", "S3ReadOnly"]
}


Commit → PR → Merge → Terraform applies.

New group + policies available in AWS IAM.

3. Access Request (Add User to Group)

Steps:

Edit variables.tf → update user_groups map:

variable "user_groups" {
  default = {
    alice   = ["readonly"]
    bob     = ["devops"]
    newuser = ["s3-rw", "newgroup"]   # <-- updated
  }
}


Commit → PR → Merge → Terraform applies.

User membership updated automatically.

🔍 Verification

After deployment, verify access in AWS:

CLI:

aws iam list-groups-for-user --user-name newuser


Console:
IAM → Users → newuser → Groups tab.

🔄 Rollback

To revert:

Remove the user/group mapping in Terraform (variables.tf or locals.tf).

Commit → PR → Merge.

Terraform will remove memberships or groups automatically.

🚀 Automation Enhancements (Future)

Self-service input file: Maintain users.yaml mapping users → groups, parse in GitHub Actions.

Workflow dispatch: Allow security engineers to run workflow with inputs (username, groups) without editing code.

Ticket integration (ServiceNow/Jira): On ticket approval, auto-trigger PR with changes.

📖 Example Ticket Flow

User requests access via ticket.

Security engineer verifies approval.

Engineer updates Terraform (users, groups, user_groups).

PR created referencing ticket ID.

Merge after review → GitHub Actions apply.

Engineer verifies in AWS → ticket closed.

✅ This runbook standardizes IAM access requests with automation, reviews, and audit trails.