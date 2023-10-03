provider "github" {
token = "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"
}

resource "github_repository" "Repo_using_terraform" {
  name        = "Repo_using_terraform"
  description = "This is my first repository using Terraform"
  visibility = "public"
  auto_init = true
}