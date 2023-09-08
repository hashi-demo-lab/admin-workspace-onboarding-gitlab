# Data lookups
## Organization name
data "tfe_organization" "this_org" {
  name = var.organization
}

data "tfe_agent_pool" "this_pool" {
  count        = var.workspace_agents ? 1 : 0
  name         = var.agent_pool_name
  organization = data.tfe_organization.this_org.name
}

data "tfe_project" "this_project" {
  count        = var.create_project ? 0 : 1
  name         = var.project_name
  organization = data.tfe_organization.this_org.name
}

###################################################
# Resources
## Workspace setup
resource "tfe_workspace" "this_ws" {
  name                      = var.workspace_name
  organization              = data.tfe_organization.this_org.name
  description               = var.workspace_description
  tag_names                 = var.workspace_tags
  terraform_version         = (var.workspace_terraform_version == "latest" ? null : var.workspace_terraform_version)
  working_directory         = (var.workspace_vcs_directory == "root_directory" ? null : var.workspace_vcs_directory)
  queue_all_runs            = var.queue_all_runs
  auto_apply                = var.workspace_auto_apply
  assessments_enabled       = var.assessments_enabled
  project_id                = var.create_project ? tfe_project.project[0].id : try(data.tfe_project.this_project[0].id, data.tfe_organization.this_org.default_project_id)
  agent_pool_id             = var.workspace_agents ? data.tfe_agent_pool.this_pool[0].id : null
  execution_mode            = var.workspace_agents ? "agent" : var.execution_mode
  remote_state_consumer_ids = var.remote_state ? var.remote_state_consumers : null
  file_triggers_enabled     = var.file_triggers_enabled

  dynamic "vcs_repo" {
    for_each = lookup(var.vcs_repo, "identifier", null) == null ? [] : [var.vcs_repo]

    content {
      identifier         = lookup(vcs_repo.value, "identifier", null)
      branch             = lookup(vcs_repo.value, "branch", null)
      ingress_submodules = lookup(vcs_repo.value, "ingress_submodules", null)
      oauth_token_id     = lookup(vcs_repo.value, "oauth_token_id", null)
      tags_regex         = lookup(vcs_repo.value, "tags_regex", null)
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

## Variables
resource "tfe_variable" "variables" {
  for_each     = var.variables
  workspace_id = tfe_workspace.this_ws.id
  key          = each.key
  value        = each.value["value"]
  description  = lookup(each.value, "description", null)
  category     = lookup(each.value, "category", "terraform")
  sensitive    = lookup(each.value, "sensitive", false)
  hcl          = lookup(each.value, "hcl", false)
}

// Projects
resource "tfe_project" "project" {
  count        = var.create_project ? 1 : 0
  organization = data.tfe_organization.this_org.name
  name         = var.project_name
}


# RBAC
## Teams
### Workspace owner
# resource "tfe_team" "this_owners" {
#   name         = "${var.workspace_name}-owners"
#   organization = data.tfe_organization.this_org.name
# }

# module "workspace_owner" {
#   source = "./modules/rbac_user"

#   organization     = data.tfe_organization.this_org.name
#   workspace_id     = tfe_workspace.this_ws.id
#   team_id          = tfe_team.this_owners.id
#   user_email       = var.workspace_owner_email
#   user_permissions = "admin"
# }

# ### Read access team
# resource "tfe_team" "this_read" {
#   name         = "${var.workspace_name}-read"
#   organization = data.tfe_organization.this_org.name
# }

# module "workspace_read" {
#   source = "./modules/rbac_user"

#   for_each         = toset(var.workspace_read_access_emails)
#   organization     = data.tfe_organization.this_org.name
#   workspace_id     = tfe_workspace.this_ws.id
#   team_id          = tfe_team.this_read.id
#   user_email       = each.key
#   user_permissions = "read"
# }

# ### Write access team
# resource "tfe_team" "this_write" {
#   name         = "${var.workspace_name}-write"
#   organization = data.tfe_organization.this_org.name
# }

# module "workspace_write" {
#   source = "./modules/rbac_user"

#   for_each         = toset(var.workspace_write_access_emails)
#   organization     = data.tfe_organization.this_org.name
#   workspace_id     = tfe_workspace.this_ws.id
#   team_id          = tfe_team.this_write.id
#   user_email       = each.key
#   user_permissions = "write"
# }

# ### Plan access team
# resource "tfe_team" "this_plan" {
#   name         = "${var.workspace_name}-plan"
#   organization = data.tfe_organization.this_org.name
# }

# module "workspace_plan" {
#   source = "./modules/rbac_user"

#   for_each         = toset(var.workspace_plan_access_emails)
#   organization     = data.tfe_organization.this_org.name
#   workspace_id     = tfe_workspace.this_ws.id
#   team_id          = tfe_team.this_plan.id
#   user_email       = each.key
#   user_permissions = "plan"
# }
