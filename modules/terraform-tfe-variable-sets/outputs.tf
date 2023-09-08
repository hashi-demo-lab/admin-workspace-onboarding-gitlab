output "variable_set" {
  value       = var.create_variable_set ? tfe_variable_set.set : data.tfe_variable_set.data
  description = "Output of the Variable Set that has been created or updated"
}

output "variable_set_name" {
  value       = var.create_variable_set ? tfe_variable_set.set[0].name : data.tfe_variable_set.data[0].name
  description = "Output for the name of the variable set that has been created or updated"
}

