data "azurerm_client_config" "current" {}

locals {
  current_user_id = coalesce(var.msi_id, data.azurerm_client_config.current.object_id)
}

# locals {
#   container_hostname = regex("[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+\\.[a-zA-Z0-9-]+", var.container_app_url)[0]
# }


# Define Azure Key Vault resource
resource "azurerm_key_vault" "vault" {
  name                        = var.key_vault_name
  location                    = var.region
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.sku_name
 
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = var.key_permissions
    secret_permissions = var.secret_permissions
  }
}

resource "azurerm_key_vault_secret" "vault_secret_five9connect" {
  name         = "five9connect"
  value        = jsonencode({
    CONTAINER_URL = jsondecode(var.container_app_url)["five9connect"],
    ANOTHER_VALUE = "five9connect_another_value",
    CLIENT_ID = "yet_another_value",
    APP_URL = jsondecode(var.app_url)["five9connect"]
  })
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_key_vault_secret" "vault_secret_conversa" {
  name         = "conversa"
  value        = jsonencode({
    CONTAINER_URL = jsondecode(var.container_app_url)["five9connect"],
    ANOTHER_VALUE = "conversa_another_value",
    CLIENT_ID = "yet_another_value",
    APP_URL = jsondecode(var.app_url)["five9connect"]
  })
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_key_vault_secret" "vault_secret_dbrunner" {
  name         = "dbrunner"
  value        = jsonencode({
    CONTAINER_URL = jsondecode(var.container_app_url)["five9connect"],
    ANOTHER_VALUE = "dbrunner_another_value",
    CLIENT_ID = "yet_another_value",
    APP_URL = jsondecode(var.app_url)["five9connect"]
  })
  key_vault_id = azurerm_key_vault.vault.id
}

resource "azurerm_key_vault_secret" "vault_secret_airunner" {
  name         = "airunner"
  value        = jsonencode({
    CONTAINER_URL = jsondecode(var.container_app_url)["five9connect"],
    ANOTHER_VALUE = "airunner_another_value",
    CLIENT_ID = "yet_another_value",
    APP_URL = jsondecode(var.app_url)["five9connect"]
  })
  key_vault_id = azurerm_key_vault.vault.id
}

# output "container_hostname" {
#   value = var.container_app_url
# }

# output "container_hostname_1" {
#   value = jsondecode(var.container_app_url)["five9connect"]
# }


# output "container_url_parts" {
#   value = local.container_url_parts
# }

# # Example output
# output "example_output" {
#   value = "example_output_value"
# }
 
# # Now, let's update this output to Azure Key Vault
# resource "azurerm_key_vault_secret" "example_output_secret" {
#   name         = "example-output-secret"
#   value        = "${output.example_output.value}"
#   key_vault_id = azurerm_key_vault.example.id
# }