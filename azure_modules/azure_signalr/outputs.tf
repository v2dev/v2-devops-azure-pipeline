output "signalr_service_id" {
  description = "The ID of the SignalR service"
  value       = azurerm_signalr_service.signalr_service.id
}

output "signalr_service_primary_connection_string" {
  description = "The primary connection string of the SignalR service"
  value       = azurerm_signalr_service.signalr_service.primary_connection_string
  sensitive   = true
}

output "function_app_id" {
  description = "The ID of the Function App"
  value       = azurerm_function_app.callmindui_function_app.id
}

output "function_app_default_hostname" {
  description = "The default hostname of the Function App"
  value       = azurerm_function_app.callmindui_function_app.default_hostname
}