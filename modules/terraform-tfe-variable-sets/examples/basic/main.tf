module "variable-sets" {
  source              = "../../"
  organization        = "integration-testing"
  create_variable_set = true
  variable_set_name   = "my-set2"
  tags                = ["nsx"]
  variables = {
    AWS_REGION = {
      category    = "env"
      description = "(Required) AWS Region where the resources will be instantiated."
      sensitive   = false
      hcl         = false
      value       = "ap-southeast-1"
    },
    aws_tag_owner = {
      category    = "terraform"
      description = "(Required) Owner of all resources that will be created - Use an email address"
      sensitive   = false
      hcl         = false
      value       = "my-email@email.com"
    },
    aws_tag_ttl = {
      category    = "terraform"
      description = "(Required) TTL of the resources that will be provisioned for this demo. Specified in hours"
      sensitive   = false
      hcl         = false
      value       = "8760"
    },
  }
}

module "variable-sets-update" {
  source              = "../../"
  organization        = "integration-testing"
  create_variable_set = false
  variable_set_name   = module.variable-sets.variable_set_name
  tags                = ["var-set"]
  variables = {
    ADDED_VAR = {
      category    = "env"
      description = "(Required) Never gonna give you up"
      sensitive   = false
      hcl         = false
      value       = "Never gonna let you down"
    }
  }
}


module "test" {
  source              = "../../"
  organization        = "integration-testing"
  create_variable_set = true
  variable_set_name   = "my-set"
  tags                = ["nsx"]
  variables = {
    env_dev = {
      category    = "terraform"
      description = "(Required) AWS Region where the resources will be instantiated."
      sensitive   = false
      hcl         = true
      value = {
        name            = "eks-dev"
        cidr            = "10.0.0.0/16"
        private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
        public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
      }
    },
  }
}
