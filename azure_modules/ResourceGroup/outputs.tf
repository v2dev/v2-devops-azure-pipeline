output "resource_name" {
  value       = azurerm_resource_group.resource_group.name
  description = "Output name of the created Resource Group"
}

output "location" {
  value       = azurerm_resource_group.resource_group.location
  description = "The location of the created resource group."
}