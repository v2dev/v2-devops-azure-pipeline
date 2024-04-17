terraform {
  source = "../../../azure_modules//azure_signalr"
}

include {
  path = find_in_parent_folders()
}

dependency "resourcegroup" {
  config_path = "../resourcegroup"
}

include "env_vars" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  prefix              = include.env_vars.locals.prefix
  resource_group_name = dependency.resourcegroup.outputs.resource_name
  location            = dependency.resourcegroup.outputs.location
  environment         = include.env_vars.locals.environment

  tags = {
    Environment = include.env_vars.locals.environment
    Project     = "CallMind"
  }
}