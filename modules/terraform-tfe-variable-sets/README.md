# terraform-tfe-variable-sets

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | >=0.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.36.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tfe_variable.var](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable_set.set](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set) | resource |
| [tfe_workspace_variable_set.set](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set) | resource |
| [tfe_organization.org](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/organization) | data source |
| [tfe_variable_set.set](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set) | data source |
| [tfe_workspace_ids.ws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_variable_set"></a> [create\_variable\_set](#input\_create\_variable\_set) | (Optional) Conditional that will create a variable set for the variables that are being created. Defaults to true | `bool` | `true` | no |
| <a name="input_global"></a> [global](#input\_global) | (Optional) Boolean that designates whether or not the variable set applies to all workspaces in the Organization. | `bool` | `false` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | (Required) Name of the TFC Organization where the workspaces reside | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) List of tags that will be used when determining the workspace IDs. Required if create\_variable\_set is set to true. | `list(string)` | `[]` | no |
| <a name="input_variable_set_description"></a> [variable\_set\_description](#input\_variable\_set\_description) | (Optional) Description that will be tied to the variable set if one is being created. | `string` | `"Variable Set created via Terraform"` | no |
| <a name="input_variable_set_name"></a> [variable\_set\_name](#input\_variable\_set\_name) | (Required) Name of the variable set that will be created or used (if create\_variable\_set is set to false). | `string` | n/a | yes |
| <a name="input_variables"></a> [variables](#input\_variables) | n/a | <pre>map(object({<br>    category    = string<br>    description = string<br>    category    = string<br>    sensitive   = optional(bool, false)<br>    hcl         = bool<br>    value       = any<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_variable_set"></a> [variable\_set](#output\_variable\_set) | Output of the Variable Set that has been created or updated |
| <a name="output_variable_set_name"></a> [variable\_set\_name](#output\_variable\_set\_name) | Output for the name of the variable set that has been created or updated |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
