# policy_by_tag

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
| [tfe_policy_set.onboarding](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set) | resource |
| [tfe_sentinel_policy.dummy](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/sentinel_policy) | resource |
| [tfe_workspace_ids.onboarding-apps](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | TFC Organization to build under | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to search for to attach policy | `list(any)` | <pre>[<br>  "onboarding"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_ids"></a> [workspace\_ids](#output\_workspace\_ids) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
