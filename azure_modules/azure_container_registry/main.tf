resource "azurerm_container_registry" "container_registry" {
  name                = "${var.prefix}${var.environment}conregistry"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
}

resource "azurerm_user_assigned_identity" "container_registry_user_assigned_identity" {
  name                = "${var.prefix}-${var.environment}conregistryid"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_role_assignment" "container_registry_pull_role_assignment" {
  scope                = azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.container_registry_user_assigned_identity.principal_id
}