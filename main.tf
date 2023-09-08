
locals {
  workspaceConfig = flatten([for workspace in fileset(path.module, "config/*.yaml") : yamldecode(file(workspace))])
  workspaces      = { for workspace in local.workspaceConfig : workspace.workspace_name => workspace }
  #filter workspaces to only those that need a new github repo created
  workspaceRepos = { for workspace in local.workspaceConfig : workspace.workspace_name => workspace if workspace.create_repo }
  #filter workspace to only those with variables sets
  ws_varSets = { for workspace in local.workspaceConfig : workspace.workspace_name => workspace if workspace.create_variable_set }

  #loop though each workspace, then each varset and flatten
  workspace_varset = flatten([
    for key, value in local.ws_varSets : [
      for varset in value["var_sets"] :
      {
        organization        = value["organization"]
        workspace_name      = value["workspace_name"]
        create_variable_set = value["create_variable_set"]
        var_sets            = varset
      }
    ]
  ])
  #convert to a Map with variabel set name as key
  varsetMap = { for varset in local.workspace_varset : varset.var_sets.variable_set_name => varset }
}


module "terraform-tfe-variable-sets" {
  source  = "./modules/terraform-tfe-variable-sets"

  for_each = local.varsetMap

  organization             = each.value.organization
  create_variable_set      = try(each.value.create_variable_set, true)
  variables                = try(each.value.var_sets.variables, {})
  variable_set_name        = each.value.var_sets.variable_set_name
  variable_set_description = try(each.value.var_sets.variable_set_description, "")
  tags                     = try(each.value.var_sets.tags, [])
  global                   = try(each.value.var_sets.global, false)
}


module "gitlab-project-module" {
  source  = "./modules/terraform-gitlab-project-module"
  
  for_each = local.workspaceRepos

  name = each.value.gitlab.gitlab_project_name
  description  = each.value.gitlab.gitlab_repo_desc
  namespace_id = each.value.gitlab.gitlab_namespace_id
  group_with_project_templates_id = try(each.value.gitlab.group_with_project_templates_id, null)
  template_project_id = try(each.value.gitlab.gitlab_template_project_id, null)
  template_name = try(each.value.gitlab.gitlab_template_name, null)
  use_custom_template = try(each.value.gitlab.gitlab_use_custom_template, false)
}

module "workspace" {
  source  = "./modules/terraform-tfe-onboarding-module"

  depends_on = [
    module.gitlab-project-module
  ]

  for_each = local.workspaces

  organization                = each.value.organization
  create_project              = try(each.value.create_project, false)
  project_name                = try(each.value.project_name, "")
  workspace_name              = each.value.workspace_name
  workspace_description       = try(each.value.workspace_description, "")
  workspace_terraform_version = try(each.value.workspace_terraform_version, "")
  workspace_tags              = try(each.value.workspace_tags, [])
  variables                   = try(each.value.variables, {})
  assessments_enabled         = try(each.value.assessments_enabled, false)

  file_triggers_enabled   = try(each.value.file_triggers_enabled, true)
  workspace_vcs_directory = try(each.value.workspace_vcs_directory, "root_directory")
  workspace_auto_apply    = try(each.value.workspace_auto_apply, false)

  # Remote State Sharing
  remote_state           = try(each.value.remote_state, false)
  remote_state_consumers = try(each.value.remote_state_consumers, [""])

  #VCS block
  vcs_repo = try(each.value.vcs_repo, {})

  #Agents
  workspace_agents = try(each.value.workspace_agents, false)
  execution_mode   = try(each.value.execution_mode, "remote")
  agent_pool_name  = try(each.value.agent_pool_name, null)

  #RBAC
  workspace_read_access_emails  = try(each.value.workspace_read_access_emails, [])
  workspace_write_access_emails = try(each.value.workspace_write_access_emails, [])
  workspace_plan_access_emails  = try(each.value.workspace_plan_access_emails, [])
}


data "tfe_workspace_ids" "all" {
  depends_on = [
    module.workspace
  ]
  names        = ["*"]
  organization = var.organization
}

locals {
  varset_out = module.terraform-tfe-variable-sets
  gitlab_out = module.gitlab-project-module
}


# Associate varset with workspace
resource "tfe_workspace_variable_set" "set" {
  depends_on = [
    module.workspace,
    module.terraform-tfe-variable-sets
  ]
  for_each        = local.varsetMap
  variable_set_id = local.varset_out[each.value.var_sets.variable_set_name].variable_set[0].id
  workspace_id    = lookup(data.tfe_workspace_ids.all.ids, each.value.workspace_name)

} 

