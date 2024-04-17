terraform {
  source = "../../../azure_modules//azure_container_registry"
}

include {
  path = find_in_parent_folders()
}

dependency "resourcegroup" {
  config_path = "../resourcegroup"
  mock_outputs = {
    resource_name = "mockOutput"
  }
}

dependency "resourcegroup" {
  config_path = "../resourcegroup"
  mock_outputs = {
    location = "mockOutput"
  }
}

# dependency "vnet" {
#   config_path   = "../vnet"
#   mock_outputs  = {
#     virtual_network_id = "mockOutput"
#   }
# }

include "env_vars" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  
  prefix                                    = include.env_vars.locals.prefix
  environment                               = include.env_vars.locals.environment
  location                                  = dependency.resourcegroup.outputs.location
  resource_group_name                       = dependency.resourcegroup.outputs.resource_name
  sku                                       = "Premium"
}