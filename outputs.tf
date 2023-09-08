
output "varsetMap" {
  value = local.varsetMap
}

output "variable_set" {
  value = module.terraform-tfe-variable-sets
} 

output "gitlab_out" {
  value = local.gitlab_out
  sensitive = true
} 