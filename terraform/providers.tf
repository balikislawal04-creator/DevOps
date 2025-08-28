# providers.tf
provider "aws" {
  region = var.region  # has default "us-east-1" in variables.tf
}
