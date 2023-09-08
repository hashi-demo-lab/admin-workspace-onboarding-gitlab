# rbac_user

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_team_access.this_access](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_organization_member.this_member](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_organization_member) | resource |
| [tfe_organization_membership.this_membership](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization_membership) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | Name of the organization to find users | `string` | n/a | yes |
| <a name="input_team_id"></a> [team\_id](#input\_team\_id) | ID of team to add a user to | `string` | n/a | yes |
| <a name="input_user_email"></a> [user\_email](#input\_user\_email) | Email for the owner of the account | `string` | n/a | yes |
| <a name="input_user_permissions"></a> [user\_permissions](#input\_user\_permissions) | Permission level to grant to user | `string` | n/a | yes |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The ID of the workspace to add access to | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
