terraform {
  source = "../../../azure_modules//vnet"
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
  prefix                            = include.env_vars.locals.prefix
  location                          = dependency.resourcegroup.outputs.location
  environment                       = include.env_vars.locals.environment
  resource_group_name               = dependency.resourcegroup.outputs.resource_name
  network_address_space             = "10.0.0.0/16"
  container_subnet_address_prefix   = "10.0.4.0/23"
  appgw_subnet_address_prefix       = "10.0.2.0/24"
  storage_subnet_address_prefix     = "10.0.3.0/24"
  
  tags = {
    Project = "CallMind"
  }
}