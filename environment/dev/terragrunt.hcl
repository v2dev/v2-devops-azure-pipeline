locals {
  provider_version = "3.89.0"
}

# Inject the remote backend configuration in all the modules that includes the root file without having to define them in the underlying module.

remote_state {
  backend = "azurerm"
  generate = {
    path      = "grunt_backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    resource_group_name  = "v2devops-new"
    storage_account_name = "statecsdev"
    container_name       = "dev"
    key                  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "azurerm" {
  features {}
  skip_provider_registration = true
}
EOF
}
