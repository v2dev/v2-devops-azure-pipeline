output "container_app_subnet" {
  value       = azurerm_subnet.container_app_subnet.id
  description = "The ID of the container app subnet"
}

output "app_gw_subnet_id" {
  value       = azurerm_subnet.app_gw_subnet.id
  description = "The ID of the application gateway subnet"
}

output "storage_subnet_id" {
  value       = azurerm_subnet.storage_subnet.id
  description = "The ID of the storage subnet"
}

output "virtual_network_id" {
  value       = azurerm_virtual_network.virtual_network.id
  description = "The ID of the virtual network"
}