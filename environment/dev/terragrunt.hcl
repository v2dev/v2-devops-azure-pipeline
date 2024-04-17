# Inject the remote backend configuration in all the modules that includes the root file without having to define them in the underlying module.

remote_state {
  backend = "azurerm"
  generate = {
    path      = "grunt_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "rg-terragrunt-backend-state"
    storage_account_name = "callmindterraformstate"
    container_name       = "devstatefile"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

