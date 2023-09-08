terraform {
  required_version = ">= 1.3.0"

  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 16.0"
    }
  }
}
