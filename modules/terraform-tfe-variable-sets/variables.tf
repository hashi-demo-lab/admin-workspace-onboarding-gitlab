variable "variables" {
  type = map(object({
    category    = string
    description = string
    category    = string
    sensitive   = optional(bool, false)
    hcl         = bool
    value       = any
  }))
}

variable "organization" {
  description = "(Required) Name of the TFC Organization where the workspaces reside"
  type        = string
}

variable "create_variable_set" {
  type        = bool
  description = "(Optional) Conditional that will create a variable set for the variables that are being created. Defaults to true"
  default     = true
}

variable "variable_set_name" {
  type        = string
  description = "(Required) Name of the variable set that will be created or used (if create_variable_set is set to false)."
}

variable "variable_set_description" {
  type        = string
  description = "(Optional) Description that will be tied to the variable set if one is being created."
  default     = "Variable Set created via Terraform"
}

variable "tags" {
  type        = list(string)
  description = "(Optional) List of tags that will be used when determining the workspace IDs. Required if create_variable_set is set to true."
  default     = []
}

variable "global" {
  type        = bool
  description = "(Optional) Boolean that designates whether or not the variable set applies to all workspaces in the Organization."
  default     = false
}
