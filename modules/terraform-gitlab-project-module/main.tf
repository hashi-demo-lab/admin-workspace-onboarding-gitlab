#####
# Projects
#####

locals {
  project_id = var.external_project_id == null ? gitlab_project.this["0"].id : var.external_project_id
  is_mirror  = var.mirror != null && var.import_url != null
}

moved {
  from = gitlab_project.this
  to   = gitlab_project.this["0"]
}

resource "gitlab_project" "this" {
  for_each = { 0 = "enabled" }

  # must-have
  name         = var.name
  description  = var.description
  namespace_id = var.namespace_id

  # high level, url-related
  import_url                          = var.import_url
  import_url_username                 = var.import_url_username
  import_url_password                 = var.import_url_password
  forked_from_project_id              = var.forked_from_project_id
  default_branch                      = var.default_branch
  mirror                              = var.import_url != null ? var.mirror : null
  mirror_overwrites_diverged_branches = local.is_mirror ? var.mirror_overwrites_diverged_branches : null
  mirror_trigger_builds               = local.is_mirror ? var.mirror_trigger_builds : null
  only_mirror_protected_branches      = local.is_mirror ? var.only_mirror_protected_branches : null
  path                                = var.path
  use_custom_template                 = var.template_project_id != null || var.template_name != null ? var.use_custom_template : null
  template_project_id                 = var.template_name == null ? var.template_project_id : null
  template_name                       = var.template_project_id == null ? var.template_name : null
  group_with_project_templates_id     = var.template_project_id != null || var.template_name != null ? var.group_with_project_templates_id : null
  visibility_level                    = var.visibility_level
  topics                              = var.topics

  # general settings
  allow_merge_on_skipped_pipeline                  = var.allow_merge_on_skipped_pipeline
  analytics_access_level                           = var.analytics_access_level
  approvals_before_merge                           = var.approvals_before_merge
  archive_on_destroy                               = var.archive_on_destroy
  archived                                         = var.archived
  auto_cancel_pending_pipelines                    = var.auto_cancel_pending_pipelines
  auto_devops_deploy_strategy                      = var.auto_devops_deploy_strategy
  auto_devops_enabled                              = var.auto_devops_enabled
  autoclose_referenced_issues                      = var.autoclose_referenced_issues
  avatar                                           = var.avatar
  avatar_hash                                      = var.avatar != null ? filesha256(var.avatar) : null
  external_authorization_classification_label      = var.external_authorization_classification_label
  issues_template                                  = var.issues_enabled ? var.issues_template : null
  merge_commit_template                            = var.merge_commit_template
  merge_method                                     = var.merge_method
  merge_requests_template                          = var.merge_requests_template
  only_allow_merge_if_all_discussions_are_resolved = var.only_allow_merge_if_all_discussions_are_resolved
  only_allow_merge_if_pipeline_succeeds            = var.only_allow_merge_if_pipeline_succeeds
  remove_source_branch_after_merge                 = var.remove_source_branch_after_merge
  resolve_outdated_diff_discussions                = var.resolve_outdated_diff_discussions
  squash_commit_template                           = var.squash_commit_template
  squash_option                                    = var.squash_option
  suggestion_commit_message                        = var.suggestion_commit_message
  request_access_enabled                           = var.request_access_enabled

  # build, pipelines, CI/CD related
  build_git_strategy              = var.build_git_strategy
  build_timeout                   = var.build_timeout
  builds_access_level             = var.builds_access_level
  ci_config_path                  = var.ci_config_path
  ci_default_git_depth            = var.ci_default_git_depth
  ci_forward_deployment_enabled   = var.ci_forward_deployment_enabled
  ci_separated_caches             = var.ci_separated_caches
  container_registry_access_level = var.container_registry_access_level
  dynamic "container_expiration_policy" {
    for_each = var.container_registry_access_level != "disabled" ? [var.container_expiration_policy] : []

    content {
      cadence           = container_expiration_policy.value["cadence"]
      enabled           = container_expiration_policy.value["enabled"]
      keep_n            = lookup(container_expiration_policy.value, "keep_n", null)
      name_regex_delete = container_expiration_policy.value["name_regex_delete"]
      name_regex_keep   = container_expiration_policy.value["name_regex_keep"]
      older_than        = container_expiration_policy.value["older_than"]
    }
  }
  public_builds          = var.public_builds
  shared_runners_enabled = var.shared_runners_enabled

  # UI features
  emails_disabled                      = var.emails_disabled
  forking_access_level                 = var.forking_access_level
  initialize_with_readme               = var.import_url == null ? var.initialize_with_readme : null
  issues_access_level                  = var.issues_enabled ? var.issues_access_level : null
  issues_enabled                       = var.issues_enabled
  lfs_enabled                          = var.lfs_enabled
  merge_pipelines_enabled              = var.merge_pipelines_enabled
  merge_requests_access_level          = var.merge_requests_enabled ? var.merge_requests_access_level : null
  merge_requests_enabled               = var.merge_requests_enabled
  merge_trains_enabled                 = var.merge_pipelines_enabled ? var.merge_trains_enabled : null
  infrastructure_access_level          = var.infrastructure_access_level
  packages_enabled                     = var.packages_enabled
  pages_access_level                   = var.pages_access_level
  printing_merge_request_link_enabled  = var.printing_merge_request_link_enabled
  repository_access_level              = var.repository_access_level
  requirements_access_level            = var.requirements_access_level
  security_and_compliance_access_level = var.security_and_compliance_access_level
  snippets_access_level                = var.snippets_enabled ? var.snippets_access_level : null
  snippets_enabled                     = var.snippets_enabled
  wiki_access_level                    = var.wiki_enabled ? var.wiki_access_level : null
  wiki_enabled                         = var.wiki_enabled

  # security
  restrict_user_defined_variables = var.restrict_user_defined_variables

/*   push_rules {
    author_email_regex            = lookup(var.push_rules, "author_email_regex", null)
    branch_name_regex             = lookup(var.push_rules, "branch_name_regex", null)
    commit_committer_check        = lookup(var.push_rules, "commit_committer_check", null)
    commit_message_negative_regex = lookup(var.push_rules, "commit_message_negative_regex", null)
    commit_message_regex          = lookup(var.push_rules, "commit_message_regex", null)
    deny_delete_tag               = lookup(var.push_rules, "deny_delete_tag", null)
    file_name_regex               = lookup(var.push_rules, "file_name_regex", null)
    max_file_size                 = lookup(var.push_rules, "max_file_size", null)
    member_check                  = lookup(var.push_rules, "member_check", null)
    prevent_secrets               = lookup(var.push_rules, "prevent_secrets", null)
    reject_unsigned_commits       = lookup(var.push_rules, "reject_unsigned_commits", null)
  } */

  lifecycle {
  }
}

#####
# Access Token
#####

resource "gitlab_project_access_token" "this" {
  for_each = var.access_tokens == null ? {} : var.access_tokens

  project      = local.project_id
  name         = each.key
  expires_at   = lookup(each.value, "expires_at", null)
  access_level = lookup(each.value, "access_level", null)

  scopes = each.value["scopes"]
}

#####
# Level MR Approvals
#####

resource "gitlab_project_level_mr_approvals" "this" {
  for_each = var.level_mr_approvals != null ? { 0 = "enabled" } : {}

  project = local.project_id

  disable_overriding_approvers_per_merge_request = lookup(var.level_mr_approvals, "disable_overriding_approvers_per_merge_request", null)
  merge_requests_author_approval                 = lookup(var.level_mr_approvals, "merge_requests_author_approval", null)
  merge_requests_disable_committers_approval     = lookup(var.level_mr_approvals, "merge_requests_disable_committers_approval", null)
  require_password_to_approve                    = lookup(var.level_mr_approvals, "require_password_to_approve", null)
  reset_approvals_on_push                        = lookup(var.level_mr_approvals, "reset_approvals_on_push", null)
}

#####
# Label
#####

resource "gitlab_project_label" "this" {
  for_each = var.labels != null ? var.labels : {}

  project = local.project_id

  name        = each.key
  description = lookup(each.value, "description")
  color       = lookup(each.value, "color")
}

#####
# Badges
#####


locals {
  badges = var.badges_use_default == true ? merge(
    {
      999 = {
        link_url  = "https://gitlab.com/%%{project_path}/-/commits/%%{default_branch}"
        image_url = "https://gitlab.com/%%{project_path}/badges/%%{default_branch}/pipeline.svg"
      }
    }, var.badges != null ? var.badges : {}
  ) : var.badges != null ? var.badges : {}
}

resource "gitlab_project_badge" "this" {
  for_each = local.badges

  project   = local.project_id
  link_url  = each.value.link_url
  image_url = each.value.image_url
}

#####
# Branch Protection
#####

resource "gitlab_branch_protection" "this" {
  for_each = toset(compact(concat([var.default_branch], var.branch_protection_branches)))

  project = local.project_id

  branch                       = each.value
  push_access_level            = var.branch_protection_push_access_level
  merge_access_level           = var.branch_protection_merge_access_level
  allow_force_push             = var.branch_protection_allow_force_push
  code_owner_approval_required = var.branch_protection_code_owner_approval_required

  dynamic "allowed_to_push" {
    for_each = var.branch_protection_allowed_to_push

    content {
      user_id = lookup(allowed_to_push.value, "user_id")
    }
  }

  dynamic "allowed_to_merge" {
    for_each = var.branch_protection_allowed_to_merge

    content {
      user_id = lookup(allowed_to_merge.value, "user_id")
    }
  }
}

#####
# Variables
#####

resource "gitlab_project_variable" "this" {
  for_each = var.variables

  project = local.project_id

  key           = each.key
  value         = lookup(each.value, "value")
  protected     = lookup(each.value, "protected", null)
  masked        = lookup(each.value, "masked", null)
  variable_type = lookup(each.value, "variable_type", null)
}

#####
# Tag Protection
#####

resource "gitlab_tag_protection" "this" {
  for_each = var.tag_protection != null ? { 0 = "enabled" } : {}

  project             = local.project_id
  tag                 = lookup(var.tag_protection, "tag")
  create_access_level = lookup(var.tag_protection, "create_access_level")
}

#####
# Push Mirror
#####

resource "gitlab_project_mirror" "this" {
  for_each = var.push_mirror != null ? { 0 = "enabled" } : {}

  project                 = local.project_id
  url                     = sensitive(lookup(var.push_mirror, "url"))
  enabled                 = lookup(var.push_mirror, "enabled")
  keep_divergent_refs     = lookup(var.push_mirror, "keep_divergent_refs")
  only_protected_branches = lookup(var.push_mirror, "only_protected_branches")
}

#####
# Hooks
#####

resource "gitlab_project_hook" "this" {
  for_each = length(var.hooks) > 0 ? var.hooks : []

  project                    = local.project_id
  url                        = lookup(each.value, "url")
  confidential_issues_events = lookup(each.value, "confidential_issues_events", null)
  confidential_note_events   = lookup(each.value, "confidential_note_events", null)
  deployment_events          = lookup(each.value, "deployment_events", null)
  enable_ssl_verification    = lookup(each.value, "enable_ssl_verification", null)
  issues_events              = lookup(each.value, "issues_events", null)
  job_events                 = lookup(each.value, "job_events", null)
  merge_requests_events      = lookup(each.value, "merge_requests_events", null)
  note_events                = lookup(each.value, "note_events", null)
  pipeline_events            = lookup(each.value, "pipeline_events", null)
  push_events                = lookup(each.value, "push_events", null)
  push_events_branch_filter  = lookup(each.value, "push_events_branch_filter", null)
  releases_events            = lookup(each.value, "releases_events", null)
  tag_push_events            = lookup(each.value, "tag_push_events", null)
  token                      = sensitive(lookup(each.value, "token", null))
  wiki_page_events           = lookup(each.value, "wiki_page_events", null)
}
