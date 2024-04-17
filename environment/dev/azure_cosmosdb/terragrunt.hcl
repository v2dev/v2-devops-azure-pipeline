terraform {
  source = "../../../azure_modules//azure_cosmosdb"
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
  prefix                    = include.env_vars.locals.prefix
  environment               = include.env_vars.locals.environment
  location                  = dependency.resourcegroup.outputs.location
  resource_group_name       = dependency.resourcegroup.outputs.resource_name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = false
  capabilities              = "EnableServerless"
  consistency_level         = "Session"
  max_interval_in_seconds   = 10
  max_staleness_prefix      = 200
  failover_priority         = 0

  tags = {
    Environment = include.env_vars.locals.environment
    Project     = "CallMind"
  }
}