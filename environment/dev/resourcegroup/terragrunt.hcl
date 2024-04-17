terraform {
  source = "../../../azure_modules//ResourceGroup"
}

include {
  path = find_in_parent_folders()
}

include "env_vars" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  prefix = include.env_vars.locals.prefix
  location    = include.env_vars.locals.location
  environment = include.env_vars.locals.environment
  tags = {
    Environment = include.env_vars.locals.environment
    Project     = "CallMind"
  }
}