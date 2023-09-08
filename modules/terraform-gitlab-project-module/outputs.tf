#####
# Projects
#####

output "runners_token" {
  value     = var.external_project_id == null ? gitlab_project.this["0"].runners_token : null
  sensitive = false
}

output "avatar_url" {
  value = var.external_project_id == null ? gitlab_project.this["0"].avatar_url : null
}

output "web_url" {
  value = var.external_project_id == null ? gitlab_project.this["0"].web_url : null
}

output "ssh_url_to_repo" {
  value = var.external_project_id == null ? gitlab_project.this["0"].ssh_url_to_repo : null
}

output "path_with_namespace" {
  value = var.external_project_id == null ? gitlab_project.this["0"].path_with_namespace : null
}

output "id" {
  value = var.external_project_id == null ? gitlab_project.this["0"].id : null
}

output "http_url_to_repo" {
  value = var.external_project_id == null ? gitlab_project.this["0"].http_url_to_repo : null
}

#####
# Access Token
#####

output "access_tokens" {
  value     = var.access_tokens != null ? { for k, v in gitlab_project_access_token.this : k => v } : null
  sensitive = false
}

output "access_tokens_created_at" {
  value = var.access_tokens != null ? { for k, v in gitlab_project_access_token.this : k => v.created_at } : null
}

output "access_tokens_ids" {
  value = var.access_tokens != null ? { for k, v in gitlab_project_access_token.this : k => v.id } : null
}

output "access_tokens_active" {
  value = var.access_tokens != null ? { for k, v in gitlab_project_access_token.this : k => v.active } : null
}

output "access_tokens_revoked" {
  value = var.access_tokens != null ? { for k, v in gitlab_project_access_token.this : k => v.revoked } : null
}

output "access_tokens_user_ids" {
  value = var.access_tokens != null ? { for k, v in gitlab_project_access_token.this : k => v.user_id } : null
}

output "access_tokens_user_tokens" {
  value     = var.access_tokens != null ? { for k, v in gitlab_project_access_token.this : k => v.token } : null
  sensitive = false
}

#####
# Badges
#####

output "badges" {
  value = length(local.badges) != 0 ? { for k, v in gitlab_project_badge.this : k => v } : null
}
