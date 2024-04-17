output "login_server" {
  value = azurerm_container_registry.container_registry.login_server
}

output "container_registry_id" {
  value = azurerm_container_registry.container_registry.id
}

output "container_registry_user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.container_registry_user_assigned_identity.id
}