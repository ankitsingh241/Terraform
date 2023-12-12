provider "github" {
token = "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"
}


resource "github_repository" "terraform_second_repo" {
  name        = "repo_using_terraform"
  description = "Creating repository using terraform."
  visibility = "public"
  auto_init = true
}



