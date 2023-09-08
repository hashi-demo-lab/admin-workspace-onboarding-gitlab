
variable "external_project_id" {
  type        = string
  description = "ID of an existing project to update."
  default     = null
}

#####
# Project
#####

variable "name" {
  type        = string
  description = "Name of the project."

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "The var.project_name must match “^[a-z0-9-]+$”."
  }
}

variable "description" {
  type = string

  validation {
    condition     = 8 <= length(var.description)
    error_message = "The var.project_description length must be greater than 8 characters."
  }
}

variable "namespace_id" {
  type        = number
  description = "The namespace (group or user) of the project. Defaults to your user."
  default = "67735147"
}

variable "allow_merge_on_skipped_pipeline" {
  type        = bool
  description = "Set to `true` if you want to treat skipped pipelines as if they finished with success."
  default     = false
}

variable "analytics_access_level" {
  type        = string
  description = " Set the analytics access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "disabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.analytics_access_level)
    error_message = "The var.analytics_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "approvals_before_merge" {
  // TODO remove this
  type        = number
  description = "Number of merge request approvals required for merging. Default is 0. This field does not work well in combination with the gitlab_project_approval_rule resource and is most likely gonna be deprecated in a future GitLab version."
  default     = 2
}

variable "archive_on_destroy" {
  type        = bool
  description = "Set to `true` to archive the project instead of deleting on destroy. If set to `true` it will entire omit the `DELETE` operation."
  default     = true
}

variable "archived" {
  type        = bool
  description = "Whether the project is in read-only mode (archived). Repositories can be archived/unarchived by toggling this parameter."
  default     = false
}

variable "auto_cancel_pending_pipelines" {
  type        = string
  description = "Auto-cancel pending pipelines. This isn’t a boolean, but `enabled`/`disabled`."
  default     = "enabled"

  validation {
    condition     = contains(["disabled", "enabled"], var.auto_cancel_pending_pipelines)
    error_message = "The var.auto_cancel_pending_pipelines must be “disabled” or “enabled”."
  }
}

variable "auto_devops_deploy_strategy" {
  type        = string
  description = "Auto Deploy strategy. Valid values are `continuous`, `manual`, `timed_incremental`."
  default     = null

  validation {
    condition     = var.auto_devops_deploy_strategy == null || try(contains(["continuous", "timed_incremental", "manual"], var.auto_devops_deploy_strategy), false)
    error_message = "The var.auto_devops_deploy_strategy must be “continuous”, “timed_incremental” or “manual”."
  }
}

variable "auto_devops_enabled" {
  type        = bool
  description = "Enable Auto DevOps for this project."
  default     = false
}

variable "autoclose_referenced_issues" {
  type        = bool
  description = "Set whether auto-closing referenced issues on default branch."
  default     = true
}

variable "avatar" {
  type        = string
  description = "A local path to the avatar image to upload. Note: not available for imported resources."
  default     = null
}

variable "build_git_strategy" {
  type        = string
  description = "The Git strategy. Defaults to `fetch`."
  default     = null
}

variable "build_timeout" {
  type        = number
  description = "The maximum amount of time, in seconds, that a job can run."
  default     = null
}

variable "builds_access_level" {
  type        = string
  description = "Set the builds access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "private"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.builds_access_level)
    error_message = "The var.builds_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "ci_config_path" {
  type        = string
  description = "Custom Path to CI config file."
  default     = null
}

variable "ci_default_git_depth" {
  type        = number
  description = "Default number of revisions for shallow cloning."
  default     = null
}

variable "ci_forward_deployment_enabled" {
  type        = bool
  description = "When a new deployment job starts, skip older deployment jobs that are still pending."
  default     = false
}

variable "ci_separated_caches" {
  type        = bool
  description = "Use separate caches for protected branches."
  default     = true
}

variable "container_registry_access_level" {
  type        = string
  description = "Set visibility of container registry, for this project. Valid values are `disabled`, `private`, `enabled`."
  default     = "disabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.container_registry_access_level)
    error_message = "The var.container_registry_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "container_expiration_policy" {
  description = <<EOF
    Set the image cleanup policy for this project. Ignored if var.container_registry_access_level is "disabled"

    cadence           (string, optional) The cadence of the policy. Valid values are: `1d`, `7d`, `14d`, `1month`, `3month`.
    enabled           (bool, optional)   If true, the policy is enabled.
    keep_n            (number, optional) The number of images to keep.
    name_regex_delete (string, optional) The regular expression to match image names to delete.
    name_regex_keep   (number, optional) The regular expression to match image names to keep.
    older_than        (string, optional) The number of days to keep images.
EOF

  type = object({
    cadence           = optional(string, "1d")
    enabled           = optional(bool, true)
    keep_n            = optional(number)
    name_regex_delete = optional(string, ".*")
    name_regex_keep   = optional(string, "^([0-9]+(\\.[0-9]+){0,2})$")
    older_than        = optional(string, "14d")
  })

  default = {}
}

variable "default_branch" {
  type        = string
  description = "The default branch for the project."
  default     = "main"
}

variable "emails_disabled" {
  type        = bool
  description = "Disable email notifications."
  default     = true
}

variable "external_authorization_classification_label" {
  type        = string
  description = "The classification label for the project."
  default     = null
}

variable "forked_from_project_id" {
  type        = number
  description = "Id of the project to fork. During create the project is forked and during an update the fork relation is changed."
  default     = null
}

variable "forking_access_level" {
  type        = string
  description = "Set the forking access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "enabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.forking_access_level)
    error_message = "The var.forking_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "import_url" {
  type        = string
  description = "Git URL to a repository to be imported. Together with `mirror = true` it will setup a Pull Mirror. This can also be used together with `forked_from_project_id` to setup a Pull Mirror for a fork. The fork takes precedence over the import. This field cannot be imported via `terraform import`."
  default     = null
}

variable "import_url_username" {
  type        = string
  description = "The username for the `import_url`. The value of this field is used to construct a valid `import_url` and is only related to the provider. This field cannot be imported using terraform import. See the examples section for how to properly use it."
  default     = null
}

variable "import_url_password" {
  type        = string
  description = "The password for the `import_url`. The value of this field is used to construct a valid `import_url` and is only related to the provider. This field cannot be imported using terraform import. See the examples section for how to properly use it."
  default     = null
  sensitive   = true
}

variable "initialize_with_readme" {
  type        = bool
  description = "Create main branch with first commit containing a README.md file."
  default     = false
}

variable "issues_access_level" {
  type        = string
  description = "Set the issues access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "enabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.issues_access_level)
    error_message = "The var.issues_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "issues_enabled" {
  type        = bool
  description = "Enable issue tracking for the project."
  default     = true
}

variable "issues_template" {
  type        = string
  description = "Sets the template for new issues in the project."
  default     = null
}

variable "lfs_enabled" {
  type        = bool
  description = "Enable LFS for the project."
  default     = false
}

variable "merge_commit_template" {
  type        = string
  description = "Template used to create merge commit message in merge requests. (Introduced in GitLab 14.5.)"
  default     = null
}

variable "merge_method" {
  type        = string
  description = "Set the merge method. Valid values are `merge`, `rebase_merge`, `ff`."
  default     = "ff"

  validation {
    condition     = contains(["merge", "rebase_merge", "ff"], var.merge_method)
    error_message = "The var.merge_method must be “merge”, “rebase_merge” or “ff”."
  }
}

variable "merge_pipelines_enabled" {
  type        = bool
  description = "Enable or disable merge pipelines."
  default     = false
}

variable "merge_requests_access_level" {
  type        = string
  description = "Set the merge requests access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "enabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.merge_requests_access_level)
    error_message = "The var.merge_requests_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "merge_requests_enabled" {
  type        = bool
  description = "Enable merge requests for the project."
  default     = true
}

variable "merge_requests_template" {
  type        = string
  description = "Sets the template for new merge requests in the project."
  default     = null
}

variable "merge_trains_enabled" {
  type        = bool
  description = "Enable or disable merge trains. Requires `merge_pipelines_enabled` to be set to `true` to take effect."
  default     = false
}

variable "mirror" {
  type        = bool
  description = "Enable project pull mirror."
  default     = false
}

variable "mirror_overwrites_diverged_branches" {
  type        = bool
  description = "Enable overwrite diverged branches for a mirrored project."
  default     = false
}

variable "mirror_trigger_builds" {
  type        = bool
  description = "Enable trigger builds on pushes for a mirrored project."
  default     = true
}

variable "only_allow_merge_if_all_discussions_are_resolved" {
  type        = bool
  description = "Set to `true` if you want allow merges only if all discussions are resolved."
  default     = true
}

variable "only_allow_merge_if_pipeline_succeeds" {
  type        = bool
  description = "Set to `true` if you want allow merges only if a pipeline succeeds."
  default     = true
}

variable "only_mirror_protected_branches" {
  type        = bool
  description = "Enable only mirror protected branches for a mirrored project."
  default     = true
}

variable "infrastructure_access_level" {
  type        = string
  description = "Set the operations access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "disabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.infrastructure_access_level)
    error_message = "The var.operations_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "packages_enabled" {
  type        = bool
  description = "Enable packages repository for the project."
  default     = false
}

variable "pages_access_level" {
  type        = string
  description = "Enable pages access control"
  default     = "disabled"

  validation {
    condition     = contains(["disabled", "private", "enabled", "public"], var.pages_access_level)
    error_message = "The var.pages_access_level must be “disabled”, “private”, “enabled”, “public” or “private”."
  }
}

variable "path" {
  type        = string
  description = "Path of the repository."
  default     = null
}

variable "printing_merge_request_link_enabled" {
  type        = bool
  description = "Show link to create/view merge request when pushing from the command line"
  default     = true
}

variable "public_builds" {
  type        = bool
  description = "If true, jobs can be viewed by non-project members."
  default     = false
}

variable "push_rules" {
  description = <<EOF
Push rules for the project.

  author_email_regex            (string, optional) All commit author emails must match this regex, e.g. @my-company.com$.
  branch_name_regex             (string, optional) All branch names must match this regex, e.g. (feature|hotfix)\/*.
  commit_committer_check        (bool, optional)   Users can only push commits to this repository that were committed with one of their own verified emails.
  commit_message_negative_regex (string, optional) No commit message is allowed to match this regex, for example ssh\:\/\/.
  commit_message_regex          (string, optional) All commit messages must match this regex, e.g. Fixed \d+\..*.
  deny_delete_tag               (bool, optional)   Deny deleting a tag.
  file_name_regex               (string, optional) All commited filenames must not match this regex, e.g. (jar|exe)$.
  max_file_size                 (number, optional) Maximum file size (MB).
  member_check                  (bool, optional)   Restrict commits by author (email) to existing GitLab users.
  prevent_secrets               (bool, optional)   GitLab will reject any files that are likely to contain secrets.
  reject_unsigned_commits       (bool, optional)   Reject commit when it’s not signed through GPG.
EOF

  type = object({
    author_email_regex            = optional(string, )
    branch_name_regex             = optional(string)
    commit_committer_check        = optional(bool, true)
    commit_message_negative_regex = optional(string)
    commit_message_regex          = optional(string, "(feat|fix|chore|tech|refactor|doc|maintenance|test|revert): ")
    deny_delete_tag               = optional(bool)
    file_name_regex               = optional(string, "(exe|tar|tar.gz|tar.xz|zip|7zip|rar|bin|jar|doc|docx|xlsx|xls)$")
    max_file_size                 = optional(number, 2)
    member_check                  = optional(bool)
    prevent_secrets               = optional(bool, true)
    reject_unsigned_commits       = optional(bool, true)
  })

  default = {}
}

variable "remove_source_branch_after_merge" {
  type        = bool
  description = "Enable `Delete source branch` option by default for all new merge requests."
  default     = true
}

variable "repository_access_level" {
  type        = string
  description = "Set the repository access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "enabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.repository_access_level)
    error_message = "The var.repository_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "request_access_enabled" {
  type        = bool
  description = "Allow users to request member access."
  default     = true
}

variable "requirements_access_level" {
  type        = string
  description = "Set the requirements access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "disabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.requirements_access_level)
    error_message = "The var.requirements_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "resolve_outdated_diff_discussions" {
  type        = bool
  description = "Automatically resolve merge request diffs discussions on lines changed with a push."
  default     = true
}

variable "restrict_user_defined_variables" {
  type        = bool
  description = "Allow only users with the Maintainer role to pass user-defined variables when triggering a pipeline."
  default     = true
}

variable "security_and_compliance_access_level" {
  type        = string
  description = "Set the security and compliance access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "private"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.security_and_compliance_access_level)
    error_message = "The var.security_and_compliance_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "shared_runners_enabled" {
  type        = bool
  description = "Enable shared runners for this project."
  default     = null
}

variable "snippets_access_level" {
  type        = string
  description = "Set the snippets access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "disabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.snippets_access_level)
    error_message = "The var.snippets_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "snippets_enabled" {
  type        = bool
  description = "Enable snippets for the project."
  default     = false
}

variable "squash_commit_template" {
  type        = string
  description = "Template used to create squash commit message in merge requests."
  default     = null
}

variable "squash_option" {
  type        = string
  description = "Squash commits when merge request. Valid values are `never`, `always`, `default_on`, or `default_off`. The default value is `default_off`."
  default     = null

  validation {
    condition     = var.squash_option == null || try(contains(["never", "always", "default_on", "default_off"], var.squash_option), false)
    error_message = "The var.squash_option must be “never”, “always”, “default_on” or “default_off”."
  }
}

variable "suggestion_commit_message" {
  type        = string
  description = "The commit message used to apply merge request suggestions."
  default     = null
}

variable "topics" {
  type        = set(string)
  description = "The list of topics for a project"
  default     = []
}

variable "template_project_id" {
  type        = string
  description = "When used with `use_custom_template`, project ID of a custom project template. This is preferable to using `template_name` since `template_name` may be ambiguous (enterprise edition). This option is mutually exclusive with `template_name`. See `gitlab_group_project_file_template` to set a project as a template project. If a project has not been set as a template, using it here will result in an error."
  default     = null
}

variable "template_name" {
  type        = string
  description = "When used without use_custom_template, name of a built-in project template. When used with use_custom_template, name of a custom project template. This option is mutually exclusive with `template_project_id`."
  default     = null
}

variable "group_with_project_templates_id" {
  type        = number
  description = "For group-level custom templates, specifies ID of group from which all the custom project templates are sourced. Leave empty for instance-level templates. Requires `use_custom_template` to be true (enterprise edition)."
  default     = null
}

variable "use_custom_template" {
  type        = bool
  description = "Use either custom instance or group (with group_with_project_templates_id) project template (enterprise edition)."
  default     = false
}

variable "visibility_level" {
  type        = string
  description = "Set to `public` to create a public project."
  default     = null
}

variable "wiki_access_level" {
  type        = string
  description = "Set the wiki access level. Valid values are `disabled`, `private`, `enabled`."
  default     = "disabled"

  validation {
    condition     = contains(["disabled", "private", "enabled"], var.wiki_access_level)
    error_message = "The var.wiki_access_level must be “disabled”, “private” or “enabled”."
  }
}

variable "wiki_enabled" {
  type        = bool
  description = "Enable wiki for the project."
  default     = false
}

#####
# Label
#####

variable "labels" {
  description = <<EOF
Allows to manage the lifecycle of a project label.
Key are the name of the label.

  color       (string, required) Color of the label given in 6-digit hex notation with leading '#' sign (e.g. `#FFAABB`) or one of the [CSS color names](https://developer.mozilla.org/en-US/docs/Web/CSS/color_value#Color_keywords).
  description (string, optional) Description of the label.
EOF

  type = map(object({
    color       = string
    description = optional(string)
  }))
  default = null
}

#####
# Branch Protection
#####

variable "branch_protection_branches" {
  type    = list(string)
  default = []
}

variable "branch_protection_push_access_level" {
  type    = string
  default = "no one"

  validation {
    condition     = contains(["maintainer", "developer", "no one"], var.branch_protection_push_access_level)
    error_message = "“var.branch_protection_push_access_level” must be “maintainer”, “developer” “no one”."
  }
}

variable "branch_protection_merge_access_level" {
  type    = string
  default = "maintainer"

  validation {
    condition     = contains(["maintainer", "developer", "no one"], var.branch_protection_merge_access_level)
    error_message = "“var.branch_protection_merge_access_level” must be “maintainer”, “developer” “no one”."
  }
}

variable "branch_protection_allow_force_push" {
  type    = bool
  default = true
}

variable "branch_protection_code_owner_approval_required" {
  type    = bool
  default = false
}

variable "branch_protection_allowed_to_push" {
  type = list(object({
    user_id = number
  }))
  default = []
}

variable "branch_protection_allowed_to_merge" {
  type = list(object({
    user_id = number
  }))
  default = []
}

#####
# Access Token
#####

variable "access_tokens" {
  description = <<EOF
Allows to manage the lifecycle of a project access token.
keys are the name to describe the project access token.

  scopes        (set(string), required) Valid values: `api`, `read_api`, `read_repository`, `write_repository`, `read_registry`, `write_registry`.
  access_level  (string, optional)      The access level for the project access token. Valid values are: `no one`, `minimal`, `guest`, `reporter`, `developer`,
  expires_at    (string, optional)      Time the token will expire it, `YYYY-MM-DD` format. Will not expire per default.
EOF

  type = map(object({
    scopes       = set(string)
    access_level = optional(string)
    expires_at   = optional(string)
  }))

  default = null
}

#####
# Level MR Approvals
#####

variable "level_mr_approvals" {
  description = <<EOF
allows to manage the lifecycle of a Merge Request-level approval rule.

    disable_overriding_approvers_per_merge_request (bool, optional) By default, users are able to edit the approval rules in merge requests.
    merge_requests_author_approval                 (bool, optional) Set to `true` if you want to allow merge request authors to self-approve merge requests.
    merge_requests_disable_committers_approval     (bool, optional) Set to `true` if you want to prevent approval of merge requests by merge request committers.
    require_password_to_approve                    (bool, optional) Set to `true` if you want to require authentication when approving a merge request.
    reset_approvals_on_push                        (bool, optional) Set to `true` if you want to remove all approvals in a merge request when new commits are pushed to its source branch. Default is `true`.
EOF

  type = object({
    disable_overriding_approvers_per_merge_request = optional(bool, true)
    merge_requests_author_approval                 = optional(bool, true)
    merge_requests_disable_committers_approval     = optional(bool, false)
    require_password_to_approve                    = optional(bool, false)
    reset_approvals_on_push                        = optional(bool, false)
  })

  default = {}
}

#####
# Variables
#####

variable "variables" {
  description = <<EOF
The gitlab_project_variable resource allows to manage the lifecycle of a CI/CD variable for a project.
keys are the name of the variables.

  value         (string, required) Value of the variable.
  protected     (bool, optional)   If set to `true`, the variable will be passed only to pipelines running on protected branches and tags. Defaults to `false`.
  masked        (bool, optional)   If set to `true`, the value of the variable will be hidden in job logs. The value must meet the masking requirements. Defaults to `false`.
  variable_type (string, optional) The type of a variable. Valid values are: `env_var`, `file`. Default is `env_var`.
EOF

  type = map(object({
    value         = string
    protected     = optional(bool)
    masked        = optional(bool)
    variable_type = optional(string)
  }))

  default = {}
}

#####
# Tag Protection
#####

variable "tag_protection" {
  description = <<EOF
Allows to manage the lifecycle of a tag protection.

    tag                 (string, required) Name of the tag or wildcard.
    create_access_level (string, required) Access levels which are allowed to create. Valid values are: `no one`, `developer`, `maintainer`.
EOF

  type = object({
    tag                 = optional(string, "*.*.*")
    create_access_level = optional(string, "maintainer")
  })

  default = {}
}

#####
# Push Mirror
#####

variable "push_mirror" {
  description = <<EOF
Allows to manage the lifecycle of a project mirror.
This is for pushing changes to a remote repository. Pull Mirroring can be configured using a combination of the import_url, mirror, and mirror_trigger_builds properties on the gitlab_project resource.

  url                     (string, sensitive, required) The URL of the remote repository to be mirrored.
  enabled                 (bool, optional)              Determines if the mirror is enabled.
  keep_divergent_refs     (bool, optional)              Determines if divergent refs are skipped.
  only_protected_branches (bool, optional)              Determines if only protected branches are mirrored.
EOF

  sensitive = true
  type = object({
    url                     = string
    enabled                 = optional(bool, true)
    keep_divergent_refs     = optional(bool, true)
    only_protected_branches = optional(bool, true)
  })

  default = null
}

#####
# Hooks
#####

variable "hooks" {
  description = <<EOF
Allows to manage the lifecycle of a project hook.

  url                        (string, required) The url of the hook to invoke.
  confidential_issues_events (bool, optional)   Invoke the hook for confidential issues events.
  confidential_note_events   (bool, optional)   Invoke the hook for confidential notes events.
  deployment_events          (bool, optional)   Invoke the hook for deployment events.
  enable_ssl_verification    (bool, optional)   Enable ssl verification when invoking the hook.
  issues_events              (bool, optional)   Invoke the hook for issues events.
  job_events                 (bool, optional)   Invoke the hook for job events.
  merge_requests_events      (bool, optional)   Invoke the hook for merge requests.
  note_events                (bool, optional)   Invoke the hook for notes events.
  pipeline_events            (bool, optional)   Invoke the hook for pipeline events.
  push_events                (bool, optional)   Invoke the hook for push events.
  push_events_branch_filter  (string, optional) Invoke the hook for push events on matching branches only.
  releases_events            (bool, optional)   Invoke the hook for releases events.
  tag_push_events            (bool, optional)   Invoke the hook for tag push events.
  token                      (string, optional) A token to present when invoking the hook. The token is not available for imported resources.
  wiki_page_events           (bool, optional)   Invoke the hook for wiki page events.
EOF

  type = set(object({
    url                        = string
    confidential_issues_events = optional(bool)
    confidential_note_events   = optional(bool)
    deployment_events          = optional(bool)
    enable_ssl_verification    = optional(bool, true)
    issues_events              = optional(bool)
    job_events                 = optional(bool)
    merge_requests_events      = optional(bool)
    note_events                = optional(bool)
    pipeline_events            = optional(bool)
    push_events                = optional(bool)
    push_events_branch_filter  = optional(string)
    releases_events            = optional(bool)
    tag_push_events            = optional(bool)
    token                      = optional(string)
    wiki_page_events           = optional(bool)
  }))

  default = []
}

#####
# Badges
#####

variable "badges_use_default" {
  description = "Adds default badge to the list of badges, the gitlab pipeline badge for the current project. This used index `999` of `var.badges`."
  type        = bool
  default     = true
}

variable "badges" {
  description = <<EOF
Allows to manage the lifecycle of group badges.
Key is free and might be anything

  link_url   (string, required) The URL linked with the badge.
  image_url  (string, required) The image URL which will be presented on group overview.
EOF

  type = map(object({
    link_url  = string
    image_url = string
  }))

  default = null
}
